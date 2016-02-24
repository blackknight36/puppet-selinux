# modules/firewall_driven/manifests/slave/service.pp
#
# == Class: firewall_driven::slave::service
#
# Manages the firewall-driven-slave service on a host.
#
# === Parameters
#
# [*ensure*]
#   What state should the slave service be in?  One of: "running" (also called
#   true), "stopped" (also called false), or undef (the default) to leave the
#   state unchanged.
#
# [*enable*]
#   Should the slave service be started at boot?  One of: true, false, or
#   undef (the default) to leave unchanged.
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
        $ensure=undef,
        $enable=undef,
        $vlan_bridge=false,
    ) {

    include 'firewall_driven::slave::params'

    if $ensure == true or $ensure == 'running' {
        if $vlan_bridge {
            $slave_ensure = 'stopped'
            $slave_with_vlb_ensure = 'running'
        } else {
            $slave_ensure = 'running'
            $slave_with_vlb_ensure = 'stopped'
        }
    } elsif $ensure == false or $ensure == 'stopped' {
        $slave_ensure = 'stopped'
        $slave_with_vlb_ensure = 'stopped'
    } else {
        $slave_ensure = undef
        $slave_with_vlb_ensure = undef
    }

    if $enable == true {
        if $vlan_bridge {
            $slave_enable = false
            $slave_with_vlb_enable = true
        } else {
            $slave_enable = true
            $slave_with_vlb_enable = false
        }
    } elsif $enable == false {
        $slave_enable = false
        $slave_with_vlb_enable = false
    } else {
        $slave_enable = undef
        $slave_with_vlb_enable = undef
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
