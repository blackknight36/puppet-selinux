# modules/dhcpd_driven/manifests/master.pp
#
# == Class: dhcpd_driven::master
#
# Configures a host to run the dhcpd-driven-master package and to serve hosts
# running the dhcpd-driven-slave package.
#
# === Parameters
#
# [*python_ver*]
#   Python version that will run the deployment.
#
# [*settings*]
#   Soure URI that provides the /etc/dhcpd-driven.conf content.
#
# [*django_user*]
#   ID of the user account under which the Django app will run within the WSGI
#   daemon.
#
# [*django_group*]
#   ID of the group account under which the Django app will run within the
#   WSGI daemon.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dhcpd_driven::master (
        $python_ver, $settings, $django_user, $django_group,
    ) {

    include 'apache'
    include 'apache::params'
    include 'dhcpd_driven::params'

    $python_base="/usr/lib/python${python_ver}/site-packages"

    package { $dhcpd_driven::params::master_packages:
        ensure  => installed,
        notify  => Service[$apache::params::services],
    }

    apache::site_config { 'dhcpd-driven-master':
        content  => template('dhcpd_driven/dhcpd-driven-master.conf.erb'),
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
