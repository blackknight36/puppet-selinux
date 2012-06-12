# modules/puppet/manifests/client.pp

class puppet::client {

    package { "puppet":
	ensure	=> installed,
    }

    if versioncmp($puppetversion, "2.6") < 0 {
        $puppet_era = "pre-2.6"
    } else {
        $puppet_era = "as-of-2.6"
    }
    file { "/etc/puppet/puppet.conf":
        group	=> "root",
        mode    => "0640",
        owner   => "root",
        require => Package["puppet"],
        seluser => "system_u",
        selrole => "object_r",
        seltype => $operatingsystem ? {
            "Fedora"    => $operatingsystemrelease ? {
                "11"    => "etc_t",
                "12"    => "etc_t",
                default => "puppet_etc_t",
            },
            default     => "etc_t",
        },
        source  => [
            "puppet:///private-host/puppet/puppet.conf",
            "puppet:///modules/puppet/puppet.conf.${puppet_era}",
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
        ],
    }

}
