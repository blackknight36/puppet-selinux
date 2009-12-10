# /etc/puppet/modules/authconfig/manifests/init.pp

class authconfig {

    package { "authconfig":
	 ensure => installed
    }

    exec { "authconfig":
        #command => 'authconfig --enableldap --enableldapauth --ldapserver="ldap://10.1.192.106,ldap://mdct-01gw,ldap://mdct-00gw" --ldapbasedn="dc=dartcontainer,dc=com" --disableldaptls --update',
        command => 'authconfig --enableldap --enableldapauth --ldapserver="ldap://10.1.192.106" --ldapbasedn="dc=dartcontainer,dc=com" --disableldaptls --update',
	require => [
            Package["authconfig"],
        ],
    	unless => "grep -q USELDAPAUTH=yes /etc/sysconfig/authconfig"
    }

}
