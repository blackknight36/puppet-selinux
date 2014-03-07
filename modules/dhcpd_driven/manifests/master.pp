# modules/dhcpd_driven/manifests/master.pp
#
# == Class: dhcpd_driven::master
#
# Configures a host to run the dhcpd-driven-master package and to serve hosts
# running the dhcpd-driven-slave package.
#
# === Parameters
#
# [*settings*]
#   Soure URI that provides the /etc/dhcpd-driven.conf content.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dhcpd_driven::master ($settings) {

    include 'apache'
    include 'apache::params'
    include 'dhcpd_driven::params'

    package { $dhcpd_driven::params::master_packages:
        ensure  => installed,
        notify  => Service[$apache::params::services],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$apache::params::services],
        notify      => Service[$apache::params::services],
        subscribe   => Package[$dhcpd_driven::params::master_packages],
    }

    file { '/etc/dhcpd-driven.conf':
        source  => $settings,
    }

}
