# modules/ntp/manifests/init.pp

class ntp {

    # TODO: drop special condition for mdct-dev12 once on F16 or later
    if $operatingsystemrelease > 15 or $hostname == 'mdct-dev12' or
       $virtual == 'kvm' {
        $ntp_package = 'chrony'
        $ntp_daemon = 'chronyd'
    } else {
        $ntp_package = 'ntp'
        $ntp_daemon = 'ntpd'
    }

    package { "$ntp_package":
        ensure  => installed
    }

    file { "ntp_conf":
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        path    => "/etc/${ntp_package}.conf",
        require => Package["$ntp_package"],
        source  => "puppet:///modules/ntp/${ntp_package}.conf",
    }

    if $ntp_package == 'ntp' {

        if $operatingsystemrelease < 14 {
            $ntpd_sysconfig = "ntpd.pre-F14"
        } else {
            $ntpd_sysconfig = "ntpd"
        }

        file { "/etc/sysconfig/ntpd":
            group       => "root",
            mode        => '0644',
            owner       => 'root',
            require     => Package["$ntp_package"],
            source      => "puppet:///modules/ntp/${ntpd_sysconfig}",
        }

        # ntp does not deal well with jitter of VM clocks
        service { "$ntp_daemon":
            enable      => $virtual ? {
                "kvm"   => false,
                default => true,
            },
            ensure      => $virtual ? {
                "kvm"   => stopped,
                default => running,
            },
            hasrestart  => true,
            hasstatus   => true,
            require             => [
                Package["$ntp_package"],
            ],
            subscribe   => [
                File['ntp_conf'],
                File['/etc/sysconfig/ntpd'],
            ],
        }

    } else {

        # chrony deals well with jitter of VM clocks
        service { "$ntp_daemon":
            enable      => true,
            ensure      => running,
            hasrestart  => true,
            hasstatus   => true,
            require             => [
                Package["$ntp_package"],
            ],
            subscribe   => [
                File['ntp_conf'],
            ],
        }

    }

}
