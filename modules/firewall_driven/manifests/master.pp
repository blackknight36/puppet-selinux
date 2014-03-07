# modules/firewall_driven/manifests/master.pp
#
# == Class: firewall_driven::master
#
# Configures a host to run the firewall-driven-master package and to serve
# hosts running the firewall-driven-slave package.
#
# === Parameters
#
# [*settings*]
#   Soure URI that provides the /etc/firewall-driven.conf content.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class firewall_driven::master ($settings) {

    include 'apache'
    include 'apache::params'
    include 'firewall_driven::params'

    package { $firewall_driven::params::master_packages:
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
        subscribe   => Package[$firewall_driven::params::master_packages],
    }

    file { '/etc/firewall-driven.conf':
        source  => $settings,
    }

}
