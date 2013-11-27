# modules/ntp/manifests/init.pp
#
# == Class: ntp
#
# Configures a host to run an NTP service, be it chronyd (preferred) or ntpd.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class ntp {

    include 'ntp::params'

    package { $ntp::params::package:
        ensure  => installed,
        notify  => Service[$ntp::params::service],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$ntp::params::service],
        notify      => Service[$ntp::params::service],
        subscribe   => Package[$ntp::params::package],
    }

    file { $ntp::params::config:
        source  => "puppet:///modules/ntp/${ntp::params::_name}.conf",
    }

    if $ntp::params::sysconfig {
        file { "/etc/sysconfig/ntpd":
            source  => "puppet:///modules/ntp/${ntp::params::sysconfig}",
        }
    }

    service { $ntp::params::service:
        enable      => $ntp::params::needed,
        ensure      => $ntp::params::needed ? {
            false   => stopped,
            default => running,
        },
        hasrestart  => true,
        hasstatus   => true,
    }

}
