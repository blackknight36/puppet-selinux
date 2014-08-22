# modules/dhcpd_driven/manifests/slave/service.pp
#
# == Class: dhcpd_driven::slave::service
#
# Manages the dhcpd-driven-slave service on a host.
#
# === Parameters
#
# [*ensure*]
#   What state should the slave service be in?  One of: "running" (the
#   default, also called true) or "stopped" (also called false).
#
# [*enable*]
#   Should the slave service be started at boot?  One of: true or false.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dhcpd_driven::slave::service (
        $ensure='running',
        $enable=true,
    ) {

    include 'dhcpd_driven::slave::params'

    service { $dhcpd_driven::slave::params::service:
        ensure      => $ensure,
        enable      => $enable,
        hasrestart  => true,
        hasstatus   => true,
    }

}
