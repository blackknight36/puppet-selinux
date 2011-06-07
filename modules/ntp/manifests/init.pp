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

    # TODO: 'systemctl is-enabled SERVICE' in Fedora 15 always returns true,
    # so attempting to disable a SERVICE will work, but will be repeated
    # indefinitely since puppet receives lies.  For now, we just let the
    # service run to avoid the perpetual noise.
    if $virtual == "kvm" and $operatingsystemrelease < 15 {
        $ntpd_enable = false
        $ntpd_ensure = "stopped"
    } else {
        $ntpd_enable = true
        $ntpd_ensure = "running"
    }
    service { "ntpd":
        enable          => $ntpd_enable,
        ensure          => $ntpd_ensure,
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
