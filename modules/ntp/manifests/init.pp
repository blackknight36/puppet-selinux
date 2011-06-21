# /etc/puppet/modules/ntp/manifests/init.pp

class ntp {

    package { "ntp":
	ensure	=> installed
    }

    file { "/etc/ntp.conf":
        group	=> "root",
        mode    => "0644",
        owner   => "root",
        require => Package["ntp"],
        source  => "puppet:///ntp/ntp.conf",
    }

    if $operatingsystemrelease < 14 {
        $ntpd_sysconfig = "ntpd.pre-F14"
    } else {
        $ntpd_sysconfig = "ntpd"
    }
    file { "/etc/sysconfig/ntpd":
        group	=> "root",
        mode    => "0644",
        owner   => "root",
        require => Package["ntp"],
        source  => "puppet:///ntp/${ntpd_sysconfig}",
    }

    service { "ntpd":
        enable          => $virtual ? {
            "kvm"       => false,
            default     => true,
        },
        ensure          => $virtual ? {
            "kvm"       => stopped,
            default     => running,
        },
	hasrestart	=> true,
	hasstatus	=> true,
	require		=> [
	    Package["ntp"],
	],
	subscribe	=> [
	    File["/etc/ntp.conf"],
            File["/etc/sysconfig/ntpd"],
	],
    }

}
