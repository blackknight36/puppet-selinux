# modules/puppet/manifests/server.pp
#
# == Class: puppet::server
#
# Configures a host as a puppet server.
#
# === Parameters
#
# [*enable*]
#   If true (default), the puppet master service will be enabled for automatic
#   startup during system boot.  Otherwise the master service will not be
#   started automatically.
#
# [*ensure*]
#   If 'running' (default), the puppet master service will be started
#   immediately, if it is not already running.  Other valid values are:
#   'stopped', false (same as 'stopped') and true (same as 'running').
#
# [*cert_name*]
#   This must match the 'certname' setting in /etc/puppet/puppet.conf in the
#   [master] section on the puppet master.
#
# [*use_puppetdb*]
#  If true, the puppet master will use puppetdb to store facts and reports.
#  The default value is false.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#   John Florian <john.florian@dart.biz>
#   Michael Watters <michael.watters@dart.biz>


class puppet::server ($enable=true, $ensure='running', $cert_name, $use_puppetdb=false) {

    include 'puppet::params'

    package { $puppet::params::server_packages:
        ensure => installed,
        notify => Service[$puppet::params::server_services],
    }

    package { 'r10k':
        ensure   => installed,
        provider => gem,
    }

    File {
        # Fedora installs puppet files mostly with group => 'root' and mode =>
        # '0644', but the following is more secure by preventing world
        # readable access:
        owner       => 'root',
        group       => 'puppet',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'puppet_etc_t',
        before      => Service[$puppet::params::server_services],
        notify      => Service[$puppet::params::server_services],
        subscribe   => Package[$puppet::params::server_packages],
    }

    $basedir = "${puppet::params::puppet_code_dir}/environments"

    if $::operatingsystem == 'CentOS' {
        file { '/etc/puppetlabs/r10k':
            ensure => directory,
            owner  => 'root',
            group  => 'puppet',
        }

        file { '/etc/puppetlabs/r10k/r10k.yaml':
            ensure => file,
            owner  => 'root',
            group  => 'puppet',
            content => template('puppet/r10k.yaml'),
            require => File['/etc/puppetlabs/r10k'],
        }
    }

    if $::operatingsystem == 'Fedora' {
        file { '/etc/r10k.yaml':
            ensure => file,
            owner  => 'root',
            group  => 'puppet',
            content => template('puppet/r10k.yaml'),
        }
    }

    if $use_puppetdb == true {
        $puppetdb_server = hiera('puppetdb_server')
        $puppetdb_port   = hiera('puppetdb_port')

        file { "${puppet::params::puppet_conf_dir}/puppetdb.conf":
            ensure  => file,
            content => template('puppet/puppetdb.conf.erb'),
        }

        file { "${puppet::params::puppet_conf_dir}/routes.yaml":
            ensure => file,
            source => 'puppet:///modules/puppet/routes.yaml',
        }
    }

    file { "${puppet::params::puppet_conf_dir}/fileserver.conf":
        ensure  => file,
        content => template('puppet/fileserver.conf'),
    }

    if $::operatingsystem == 'Fedora' {
        file { "${puppet::params::puppet_conf_dir}/auth.conf":
            ensure => file,
            source => 'puppet:///modules/puppet/auth.conf',
        }
    }

    iptables::tcp_port {
        'puppetmaster': port => '8140';
    }

    service { $puppet::params::server_services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
