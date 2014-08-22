# modules/dhcpd_driven/manifests/slave.pp
#
# == Class: dhcpd_driven::slave
#
# Configures a host to run the dhcpd-driven-slave package and to provide DHCP
# service in accordance with the dhcpd-driven-master.
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
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dhcpd_driven::slave (
        $ensure='present',
        $content=undef,
        $source=undef,
    ) {

    include 'dhcpd_driven::slave::params'

    package { $dhcpd_driven::slave::params::packages:
        ensure  => $ensure,
        before  => Service[$dhcpd_driven::slave::params::service],
        notify  => Service[$dhcpd_driven::slave::params::service],
    }

    dhcpd_driven::slave::config { 'dhcpd-driven-slave':
        content => $content,
        source  => $source,
    }

    if $ensure != 'absent' {
        include 'dhcpd_driven::slave::service'
    }

}
