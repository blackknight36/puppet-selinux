# modules/autofs/manifests/init.pp

class autofs {

    include authconfig
    include rpcidmapd

    package { "autofs":
	 ensure => installed
    }

    file { "/etc/auto.home":
        group   => "root",
        mode    => 644,
        owner   => "root",
        source  => "puppet:///modules/autofs/auto.home",
    }

    file { "/etc/auto.master":
        group   => "root",
        mode    => 644,
        owner   => "root",
	require => Package["autofs"],
        source  => "puppet:///modules/autofs/auto.master",
    }

    file { "/etc/auto.mnt":
        group   => "root",
        mode    => 644,
        owner   => "root",
        source	=> "puppet:///modules/autofs/auto.mnt",
    }

    file { "/etc/auto.mnt-local":
        group   => "root",
        mode    => 644,
        owner   => "root",
        source	=> $hostname ? {
            "mdct-dev12"        => "puppet:///modules/autofs/auto.mnt-mdct-dev12",
            "mole"              => "puppet:///modules/autofs/auto.mnt-mole",
            "mdct-dev6"         => "puppet:///modules/autofs/auto.mnt-mdct-dev6",
            "mdct-dev6-test"    => "puppet:///modules/autofs/auto.mnt-mdct-dev6",
            default             => "puppet:///modules/autofs/auto.mnt-local",
        },
    }

    file { "/pub":
	ensure	=> "/mnt/pub",
    }

    service { "autofs":
	enable		=> true,
	ensure		=> running,
	hasrestart	=> true,
	hasstatus	=> true,
	require		=> [
            Exec["authconfig"],
	    File["/pub"],
	    Package["autofs"],
	    Service["rpcidmapd"],
	],
	subscribe	=> [
	    File["/etc/auto.home"],
	    File["/etc/auto.master"],
	    File["/etc/auto.mnt"],
	    File["/etc/auto.mnt-local"],
	]
    }

}
