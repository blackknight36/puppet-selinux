# modules/yum-cron/manifests/init.pp

class yum-cron {

    package { "yum-cron":
	ensure	=> installed,
    }

    # While yum-updatesd has some nice features, it's a bloated memory pig.
    package { "yum-updatesd":
	ensure	=> absent,
    }

    file { "/etc/sysconfig/yum-cron":
        group	=> "root",
        mode    => 644,
        owner   => "root",
        require => Package["yum-cron"],
        source  => [
            "puppet:///private-host/yum-cron/yum-cron",
            "puppet:///yum-cron/yum-cron",
        ],
    }

    service { "yum-cron":
	enable		=> true,
	ensure		=> running,
	hasrestart	=> true,
	hasstatus	=> true,
	require		=> [
	    Package["yum-cron"],
	    Package["yum-updatesd"],
	],
	subscribe	=> [
	    File["/etc/sysconfig/yum-cron"],
	]
    }

}
