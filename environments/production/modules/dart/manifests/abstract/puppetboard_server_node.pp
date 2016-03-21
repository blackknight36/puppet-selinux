# modules/dart/manifests/abstract/puppetboard_server_node.pp
#
# == Class: dart::abstract::puppetboard_server_node
#
# Manages a Dart host as a puppetboard node.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === Authors
#
#   Michael Watters <michael.watters@dart.biz>


class dart::abstract::puppetboard_server_node {

    include '::dart::abstract::guarded_server_node'
    include 'openssl::ca_certificate::puppet_ca'

    class {'apache':
        network_connect => true,
        server_admin    => 'michael.watters@dart.biz',
    } ->

    class {'puppetboard':
        puppetdb_host => hiera('puppetdb_server'),
        puppetdb_port => hiera('puppetdb_port'),
        puppetdb_ssl_verify => '/etc/pki/tls/certs/puppet_ca.crt',
    }

    $user = $::puppetboard::params::user
    $group = $::puppetboard::params::group
    $threads = $::puppetboard::params::wsgi_threads
    $max_reqs = $::puppetboard::params::wsgi_max_reqs
    $docroot = $::puppetboard::params::docroot
    $wsgi_alias = $::puppetboard::params::wsgi_alias

    ::apache::site_config{'puppetboard':
        content => template('puppetboard/apache/conf.erb'),
    }

    ::sendmail::alias { 'puppetboard':
        recipient => 'root',
    }

    ::sendmail::alias { 'root':
        recipient => 'michael.watters@dart.biz',
    }

}
