# /etc/puppet/modules/puppet/manifests/init.pp

class puppet {

    package { "puppet":
	ensure	=> installed,
    }

    if versioncmp($puppetversion, "2.6") < 0 {
    } else {
        $puppet_era = ".as-of-2.6"
    }
    file { "/etc/puppet/puppet.conf":
        group	=> "root",
        mode    => 644,
        owner   => "root",
        require => Package["puppet"],
        source  => [
            "puppet:///private-host/puppet/puppet.conf",
            "puppet:///puppet/puppet.conf${puppet_era}",
        ],
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
