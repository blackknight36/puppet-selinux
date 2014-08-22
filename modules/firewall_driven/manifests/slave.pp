# modules/firewall_driven/manifests/slave.pp
#
# == Class: firewall_driven::slave
#
# Configures a host to run the firewall-driven-slave package and to provide
# netfilter service in accordance with the firewall-driven-master.
#
# === Parameters
#
# [*ensure*]
#   What state should the package be in?  One of: "present" (the default, also
#   called "installed"), "absent", "latest" or some specific version.
#
# [*content*]
#   Literal content for the slave configuration file.  One and only one of
#   "content" or "source" must be given.
#
# [*source*]
#   URI of the slave configuration file content.  One and only one of
#   "content" or "source" must be given.
#
# [*vlan_bridge*]
#   Enable the integrated vlan-bridge support?  One of: true or false (the
#   default).  If true, you must also include the vlan_bridge class
#   appropriately configured.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class firewall_driven::slave (
        $ensure='present',
        $content=undef,
        $source=undef,
        $vlan_bridge=false,
    ) {

    include 'firewall_driven::slave::params'

    package { $firewall_driven::slave::params::packages:
        ensure  => $ensure,
        before  => Service[$firewall_driven::slave::params::service],
        notify  => Service[$firewall_driven::slave::params::service],
    }

    firewall_driven::slave::config { 'firewall-driven-slave':
        content => $content,
        source  => $source,
    }

    if $ensure != 'absent' {
        class { 'firewall_driven::slave::service':
            vlan_bridge => $vlan_bridge,
        }
    }

}
