class collectd::client ( $enable = true, $ensure = 'running' ) {

    include 'collectd::params'

    $collectd_server = hiera('collectd_server')
    $collectd_user   = hiera('collectd_user')
    $collectd_pass   = hiera('collectd_pass')

    package { $collectd::params::client_packages:
        ensure => latest,
        notify => Service[$collectd::params::client_services],
    } ->

    file {'/etc/collectd.conf':
        ensure => file,
        owner => 'root',
        group => 'root',
        mode => '0644',
        content => template($collectd::params::client_template),
    } ~>

    service { $collectd::params::client_services:
        enable => $enable,
        ensure => $ensure,
    }
}
