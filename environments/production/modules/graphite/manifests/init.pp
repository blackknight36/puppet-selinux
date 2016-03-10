# modules/graphite/manifests/init.pp
#
# == Class: graphite
#
# This class manages packages and settings for graphite-web. 
#
# === Authors
#
#   Michael Watters <michael.watters@dart.biz>


class graphite() {
    
    include 'apache'
    include 'graphite::params'

    package { $graphite::params::packages:
        ensure => latest,
        notify => Service[$apache::params::services],
    } ->

    apache::site_config {'graphite-web':
        content => template('graphite/graphite-web.conf.erb'),
    }
    
}
