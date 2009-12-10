# /etc/puppet/modules/puppet/manifests/init.pp

class puppet {

    package { "puppet":
	ensure	=> installed,
    }

    file { "/etc/puppet/puppet.conf":
        group	=> "root",
        mode    => 644,
        owner   => "root",
        require => Package["puppet"],
        source  => "puppet:///puppet/puppet.conf",
    }

    service { "puppet":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> $operatingsystemrelease ? {
	    "8"		=> false,
	    default	=> true,
	},
        require		=> [
            Package["puppet"],
        ],
        subscribe	=> [
            File["/etc/puppet/puppet.conf"],
        ]
    }

}
