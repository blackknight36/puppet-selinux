class collectd::server ( $enable = true, $ensure = 'running' ) {

    include 'collectd::params'

    $collectd_user = hiera('collectd_user')
    $collectd_pass = hiera('collectd_pass')

    iptables::udp_port { 'collectd':
        port => '25826';
    }

    package { $collectd::params::server_packages:
        ensure => latest,
        notify => Service[$collectd::params::server_services],
    } ->

    file {'/etc/collectd.conf':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template($collectd::params::server_template),
    } ->

    file {'/etc/collectd.d/passwd':
        content => "${collectd_user}: ${collectd_pass}\n",
    } ~>

    service { $collectd::params::server_services:
        ensure => $ensure,
        enable => $enable,
    }

}
