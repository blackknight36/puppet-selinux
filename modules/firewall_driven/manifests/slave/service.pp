# modules/firewall_driven/manifests/slave/service.pp
#
# == Class: firewall_driven::slave::service
#
# Manages the firewall-driven-slave service on a host.
#
# === Parameters
#
# [*ensure*]
#   What state should the slave service be in?  One of: "running" (the
#   default, also called true) or "stopped" (also called false).
#
# [*enable*]
#   Should the slave service be started at boot?  One of: true (the default)
#   or false.
#
# [*vlan_bridge*]
#   Enable the integrated vlan-bridge support?  One of: true or false (the
#   default).  If true, you must also include the vlan_bridge class
#   appropriately configured.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class firewall_driven::slave::service (
        $ensure='running',
        $enable=true,
        $vlan_bridge=false,
    ) {

    include 'firewall_driven::slave::params'

    if $ensure == true or $ensure == 'running' {

        if $vlan_bridge {
            $slave_enable = false
            $slave_ensure = 'stopped'
            $slave_with_vlb_enable = true
            $slave_with_vlb_ensure = 'running'
        } else {
            $slave_enable = true
            $slave_ensure = 'running'
            $slave_with_vlb_enable = false
            $slave_with_vlb_ensure = 'stopped'
        }

    } else {
        $slave_enable = false
        $slave_ensure = 'stopped'
        $slave_with_vlb_enable = false
        $slave_with_vlb_ensure = 'stopped'
    }

    service { $firewall_driven::slave::params::service:
        ensure      => $slave_ensure,
        enable      => $slave_enable,
        hasrestart  => true,
        hasstatus   => true,
    }

    service { $firewall_driven::slave::params::service_with_vlb:
        ensure      => $slave_with_vlb_ensure,
        enable      => $slave_with_vlb_enable,
        hasrestart  => true,
        hasstatus   => true,
    }

}
