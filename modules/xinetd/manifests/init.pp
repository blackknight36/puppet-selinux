# modules/xinetd/manifests/init.pp
#
# == Class: xinetd
#
# Configures a host as a xinetd.
#
# === Parameters
#
# [*ensure*]
#   Instance is to be 'installed' (default), 'latest' or 'absent'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>

class xinetd ($ensure='latest') {

    include 'xinetd::params'

    package { $xinetd::params::packages:
        ensure  => $ensure,
        notify  => Service[$xinetd::params::service_name],
    }

    service { $xinetd::params::service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
