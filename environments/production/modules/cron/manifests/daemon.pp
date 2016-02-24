# modules/cron/manifests/daemon.pp
#
# == Class: cron::daemon
#
# Configures a host as a cron daemon.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class cron::daemon {

    include 'cron::params'

    package { $cron::params::packages:
        ensure  => installed,
        notify  => Service[$cron::params::service_name],
    }

    service { $cron::params::service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
