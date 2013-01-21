# modules/authconfig/manifests/init.pp

class authconfig {

    # Stage => early

    package { 'authconfig':
         ensure => installed
    }

    package { 'pam':
        ensure  => installed,
    }

    file { '/etc/pam.d/system-auth-ac':
        before  => Exec['authconfig'],
        group   => 'root',
        mode    => 644,
        owner   => 'root',
        require => Package['pam'],
        source  => [
            "puppet:///modules/authconfig/system-auth-ac.$operatingsystem.$operatingsystemrelease",
            'puppet:///modules/authconfig/system-auth-ac',
        ],
    }

    if  $operatingsystem == 'Fedora' and
        $operatingsystemrelease == "Rawhide" or
        $operatingsystemrelease >= 13
    {

        package { [ 'krb5-libs', 'pam_krb5' ]:
            ensure  => installed,
        }

        # As of Fedora 13, nscd (and it's dependent nss_ldap) is being
        # replaced by sssd, but oddly the packaging doesn't obsolete it, so we
        # do so here.
        package { 'nss_ldap':
            ensure  => absent,
        }

        package { 'nscd':
            ensure  => absent,
            require => Package['nss_ldap'],
        }

        package { 'sssd':
            ensure  => installed,
            require => Package['nscd'],
        }

        file { '/etc/pam.d/password-auth-ac':
            group   => 'root',
            mode    => '0644',
            owner   => 'root',
            require => Package['pam'],
            source  => [
                'puppet:///modules/authconfig/password-auth-ac',
            ],
        }

        # As of Fedora 13, encryption is required to a directory server if it
        # is to be used for authentication.  Since MDCT's LDAP server doesn't
        # provide encryption, authentication is configured for Kerberos
        # against the Active Directory while all other user account
        # information continues to be obtained from LDAP.
        exec { 'authconfig':
            before  => File['/etc/sssd/sssd.conf'],
            command => 'authconfig --enableldap --disableldapauth --ldapserver="ldap://10.1.192.106" --ldapbasedn="dc=dartcontainer,dc=com" --disableldaptls --enablesssd --disablesssdauth --enablekrb5 --krb5realm=DARTCONTAINER.COM --krb5kdc=dartcontainer.com --enablecachecreds --updateall --disablefingerprint',
            require => [
                File['/etc/pam.d/password-auth-ac'],
                File['/etc/pam.d/system-auth-ac'],
                Package['authconfig'],
                Package['krb5-libs'],
                Package['nscd'],
                Package['pam_krb5'],
                Package['sssd'],
            ],
            unless => 'grep -q "^ *USEKERBEROS=yes" /etc/sysconfig/authconfig'
        }

        # According to F13's authconfig(8), authconfig does NOT configure the
        # domain in sssd.conf; it must be done manually.  Hence a starter
        # sssd.conf is provided here.
        if  $operatingsystemrelease == "Rawhide" or
            $operatingsystemrelease >= 15
        {
            $sssd_conf = 'sssd.conf.Fedora.15+'
        } else {
            $sssd_conf = 'sssd.conf'
        }
        file { '/etc/sssd/sssd.conf':
            group   => 'root',
            mode    => '0600',
            owner   => 'root',
            require => Package['sssd'],
            source  => [
                "puppet:///private-host/authconfig/$sssd_conf",
                "puppet:///modules/authconfig/$sssd_conf",
            ],
        }

        service { 'sssd':
            enable          => true,
            ensure          => running,
            hasrestart      => true,
            hasstatus       => true,
            require         => [
                Exec['authconfig'],
                Package['sssd'],
            ],
            subscribe       => [
                File['/etc/sssd/sssd.conf'],
            ],
        }

    }

}
