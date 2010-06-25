# /etc/puppet/modules/authconfig/manifests/init.pp

class authconfig {

    package { "authconfig":
	 ensure => installed
    }

    package { "nss_ldap":
	 ensure => installed
    }

    package { "pam":
        ensure  => installed,
    }

    package { "nscd":
	ensure	=> installed,
    }

    service { "nscd":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Package["nscd"],
        ],
    }

    if $operatingsystem == "Fedora" and $operatingsystemrelease >= 13 {
        exec { "allow-use-nfs-home-dirs":
            command => "setsebool -P use_nfs_home_dirs on",
            unless  => "getsebool use_nfs_home_dirs | grep -q -- 'on$'",
        }
    }

    file { "/etc/pam.d/system-auth-ac":
        group   => "root",
        mode    => 644,
        owner   => "root",
        require => Package["pam"],
        source  => [
            "puppet:///authconfig/system-auth-ac.$operatingsystem.$operatingsystemrelease",
            "puppet:///authconfig/system-auth-ac",
        ],
    }

    exec { "authconfig":
        #command => 'authconfig --enableldap --enableldapauth --ldapserver="ldap://10.1.192.106,ldap://mdct-01gw,ldap://mdct-00gw" --ldapbasedn="dc=dartcontainer,dc=com" --disableldaptls --update-all',
        command => 'authconfig --enableldap --enableldapauth --ldapserver="ldap://10.1.192.106" --ldapbasedn="dc=dartcontainer,dc=com" --disableldaptls --updateall',
	require => [
            File["/etc/pam.d/system-auth-ac"],
            Package["authconfig"],
            Package["nss_ldap"],
        ],
    	unless => "grep -q USELDAPAUTH=yes /etc/sysconfig/authconfig"
    }

}
