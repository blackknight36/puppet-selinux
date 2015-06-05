# modules/authconfig/manifests/init.pp
#
# == Class: authconfig
#
# Configures user authentication on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*enable*]
#   Instance is to be started at boot.  Either true (default) or false.
#
# [*ensure*]
#   Instance is to be 'running' (default) or 'stopped'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class authconfig (
        $enable=true,
        $ensure='running',
    ) inherits ::authconfig::params {

    # nscd (and it's dependencies) have been replaced by sssd, but oddly
    # the packaging may not obsolete it, so we do so here.
    yum::remove { 'nscd': }

    package { $authconfig::params::packages:
        ensure  => installed,
        before  => Exec['authconfig'],
        require => Yum::Remove['nscd'],
        notify  => Service[$authconfig::params::service_name],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$authconfig::params::service_name],
        notify      => Service[$authconfig::params::service_name],
        subscribe   => Package[$authconfig::params::packages],
    }

    file { '/etc/pam.d/system-auth-ac':
        before  => Exec['authconfig'],
        source  => [
            "puppet:///modules/authconfig/system-auth-ac.${operatingsystem}.${operatingsystemrelease}",
            'puppet:///modules/authconfig/system-auth-ac',
        ],
    }

    file { '/etc/pam.d/password-auth-ac':
        before  => Exec['authconfig'],
        source  => 'puppet:///modules/authconfig/password-auth-ac',
    }

    # Fedora requires encryption to a directory server if it is to be used for
    # authentication.  Since MDCT's LDAP server doesn't provide encryption,
    # authentication is configured for Kerberos against the Active Directory
    # while all other user account information continues to be obtained from
    # LDAP.
    exec { 'authconfig':
        before  => File['/etc/sssd/sssd.conf'],
        command => 'authconfig --enableldap --disableldapauth --ldapserver="ldap://10.1.192.106" --ldapbasedn="dc=dartcontainer,dc=com" --disableldaptls --enablesssd --disablesssdauth --enablekrb5 --krb5realm=DARTCONTAINER.COM --krb5kdc=dartcontainer.com --enablecachecreds --updateall --disablefingerprint',
        unless => 'grep -q "^ *USEKERBEROS=yes" /etc/sysconfig/authconfig'
    }

    # According to authconfig(8), authconfig does NOT configure the domain in
    # sssd.conf; it must be done manually.  Hence a starter sssd.conf is
    # provided here.
    file { '/etc/sssd/sssd.conf':
        mode    => '0600',
        seltype => "$authconfig::params::sssd_seltype",
        source  => [
            "puppet:///private-host/authconfig/$authconfig::params::sssd_conf",
            "puppet:///modules/authconfig/$authconfig::params::sssd_conf",
        ],
    }

    service { $authconfig::params::service_name:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
