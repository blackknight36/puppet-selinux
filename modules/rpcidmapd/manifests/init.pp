# /etc/puppet/modules/rpcidmapd/manifests/init.pp

class rpcidmapd {

    package { "nfs-utils":
	 ensure => installed
    }

    package { "nfs-utils-lib":
	 ensure => installed
    }

    file { "/etc/idmapd.conf":
        group   => "root",
        mode    => 644,
        owner   => "root",
	require => Package["nfs-utils-lib"],
        source	=> "puppet:///rpcidmapd/idmapd.conf",
    }

    service { "rpcidmapd":
	enable		=> true,
	ensure		=> running,
	hasrestart	=> true,
	hasstatus	=> true,
	require		=> [
	    Package["nfs-utils"],
	    Package["nfs-utils-lib"],
	],
	subscribe	=> [
	    File["/etc/idmapd.conf"],
	]
    }

}
