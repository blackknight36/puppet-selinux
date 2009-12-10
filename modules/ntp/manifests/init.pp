# /etc/puppet/modules/ntp/manifests/init.pp

class ntp {

    package { "ntp":
	ensure	=> installed
    }

    file { "/etc/ntp.conf":
        group	=> "root",
        mode    => 644,
        owner   => "root",
        require => Package["ntp"],
        source  => "puppet:///ntp/ntp.conf",
    }

    service { "ntpd":
	enable		=> true,
	ensure		=> running,
	hasrestart	=> true,
	hasstatus	=> true,
	require		=> [
	    Package["ntp"],
	],
	subscribe	=> [
	    File["/etc/ntp.conf"],
	]
    }

}
