# modules/ntp/manifests/init.pp
#
# == Class: ntp
#
# Configures a host to run an NTP service, be it chronyd (preferred) or ntpd.
#
# === Parameters
#
# [*allow_clients*]
#   An array of strings with each specifying a subnet (e.g., '192.168.1.0/24')
#   that is permitted to use the host as a time source via NTP.  This
#   parameter is only supported via 'chrony' and ignored if 'ntp' is used.
#   A value of undef (the default) is to disallow client access to this host
#   as a time source.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class ntp ($allow_clients=undef) {

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
        content => template("ntp/${ntp::params::_name}.conf"),
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
