# /etc/puppet/modules/authconfig/manifests/init.pp

class authconfig {

    package { "authconfig":
         ensure => installed
    }

    package { "pam":
        ensure  => installed,
    }

    file { "/etc/pam.d/system-auth-ac":
        before  => Exec["authconfig"],
        group   => "root",
        mode    => 644,
        owner   => "root",
        require => Package["pam"],
        source  => [
            "puppet:///authconfig/system-auth-ac.$operatingsystem.$operatingsystemrelease",
            "puppet:///authconfig/system-auth-ac",
        ],
    }

    if $operatingsystem == "Fedora" {
        if $operatingsystemrelease < 13 {

            package { "nss_ldap":
                ensure  => installed
            }

            package { "nscd":
                ensure  => installed,
                require => Package["nss_ldap"],
            }

            service { "nscd":
                enable          => true,
                ensure          => running,
                hasrestart      => true,
                hasstatus       => true,
                require         => Package["nscd"],
            }

            exec { "authconfig":
                command => 'authconfig --enableldap --enableldapauth --ldapserver="ldap://10.1.192.106" --ldapbasedn="dc=dartcontainer,dc=com" --disableldaptls --updateall',
                require => [
                    File["/etc/pam.d/system-auth-ac"],
                    Package["authconfig"],
                    Service["nscd"],
                ],
                unless => "grep -q USELDAPAUTH=yes /etc/sysconfig/authconfig"
            }

        } else { # this is Fedora 13 or later

            # As of Fedora 13, the policy is more strict and this is required
            # for logins to gain access to the user's home dir, if it is on
            # NFS.  Interestingly, this only affects the cd within login as it
            # is still possible to enter the home dir after login when this is
            # off.
            if $selinux == "true" {
                selboolean { "use_nfs_home_dirs":
                    persistent      => true,
                    value           => on,
                }
            }

            package { "krb5-libs":
                ensure  => installed,
            }

            # As of Fedora 13, nscd (and it's dependent nss_ldap) is being
            # replaced by sssd, but oddly the packaging doesn't obsolete it,
            # so we do so here.
            package { "nss_ldap":
                ensure  => absent,
            }

            package { "nscd":
                ensure  => absent,
                require => Package["nss_ldap"],
            }

            package { "sssd":
                ensure  => installed,
                require => Package["nscd"],
            }

            # As of Fedora 13, encryption is required to a directory server if
            # it is to be used for authentication.  Since MDCT's LDAP server
            # doesn't provide encryption, authentication is configured for
            # Kerberos against the Active Directory while all other user
            # account information continues to be obtained from LDAP.
            exec { "authconfig":
                before  => File["/etc/sssd/sssd.conf"],
                command => 'authconfig --enableldap --disableldapauth --ldapserver="ldap://10.1.192.106" --ldapbasedn="dc=dartcontainer,dc=com" --disableldaptls --enablesssd --disablesssdauth --enablekrb5 --krb5realm=DARTCONTAINER.COM --krb5kdc=dartcontainer.com --enablecachecreds --updateall --disablefingerprint',
                require => [
                    File["/etc/pam.d/system-auth-ac"],
                    Package["authconfig"],
                    Package["krb5-libs"],
                    Package["nscd"],
                    Package["sssd"],
                ],
                unless => "grep -q USEKERBEROS=yes /etc/sysconfig/authconfig"
            }

            # According to F13's authconfig(8), authconfig does NOT configure
            # the domain in sssd.conf; it must be done manually.  Hence
            # a starter sssd.conf is provided here.
            if $operatingsystem == "Fedora" and $operatingsystemrelease >= 15 {
                $sssd_conf = "sssd.conf.Fedora.15+"
            } else {
                $sssd_conf = "sssd.conf"
            }
            file { "/etc/sssd/sssd.conf":
                group   => "root",
                mode    => "0600",
                owner   => "root",
                require => Package["sssd"],
                source  => "puppet:///authconfig/$sssd_conf",
            }

            service { "sssd":
                enable          => true,
                ensure          => running,
                hasrestart      => true,
                hasstatus       => true,
                require         => [
                    Exec["authconfig"],
                    Package["sssd"],
                ],
                subscribe       => [
                    File["/etc/sssd/sssd.conf"],
                ],
            }

        }

    }

}
