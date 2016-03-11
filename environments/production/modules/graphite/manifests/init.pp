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
    
    include 'graphite::params'

    package { $graphite::params::packages:
        ensure => latest,
        notify => Service[$apache::params::services],
    } 

    exec { $::graphite::params::db_sync_cmd:
        creates => '/var/lib/graphite-web/index',
    }

    $graphite_secret_key = $::graphite::params::graphite_secret_key

    file { '/etc/graphite-web/local_settings.py':
        ensure => file,
        content => template('graphite/local_settings.py.erb'),
    }

    file { '/etc/graphite-web/graphTemplates.conf':
        selrole => 'object_r',
        seltype => 'httpd_config_t',
        source  => 'puppet:///modules/graphite/graphTemplates.conf',
    }

    apache::site_config {'graphite-web':
        content => template('graphite/graphite-web.conf.erb'),
    } ~>

    service { $graphite::params::services:
        ensure => running,
        enable => true,
    }
    
}
