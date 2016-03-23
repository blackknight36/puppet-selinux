# modules/puppet/manifests/server.pp
#
# == Class: puppet::server
#
# Configures a host as a puppet server.
#
# === Parameters
#
# [*enable*]
#   This option is only honored when "use_passenger" is false.
#
#   If true (default), the puppet master service will be enabled for automatic
#   startup during system boot.  Otherwise the master service will not be
#   started automatically.
#
# [*ensure*]
#   This option is only honored when "use_passenger" is false.
#
#   If 'running' (default), the puppet master service will be started
#   immediately, if it is not already running.  Other valid values are:
#   'stopped', false (same as 'stopped') and true (same as 'running').
#
# [*use_passenger*]
#   If true (default), the puppet master will serve TCP port 8140 (the
#   standard) using Apache httpd via the Phusion Passenger rack server.
#   Otherwise, the port will be served using Ruby's own Webrick server which
#   is only suitable for small scale deployments and/or testing.
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


class puppet::server (
        $enable=true, $ensure='running', $use_passenger, $cert_name, 
        $use_puppetdb=false
    ) {

    include 'puppet::params'

    if $use_passenger {
        include 'puppet::server::passenger'
    }

    package { $puppet::params::server_packages:
        ensure  => installed,
        notify  => $use_passenger ? {
            true    => Service[$apache::params::services],
            default => Service[$puppet::params::server_services],
        },
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
        before      => $use_passenger ? {
            true    => Service[$apache::params::services],
            default => Service[$puppet::params::server_services],
        },
        notify      => $use_passenger ? {
            true    => Service[$apache::params::services],
            default => Service[$puppet::params::server_services],
        },
        subscribe   => Package[$puppet::params::server_packages],
    }

    if $use_puppetdb == true {
        $puppetdb_server = hiera('puppetdb_server')
        $puppetdb_port   = hiera('puppetdb_port')

        file { "${puppet::params::puppet_conf_dir}/puppetdb.conf":
            ensure => file,
            content => template('puppet/puppetdb.conf.erb'),
        }

        file { "${puppet::params::puppet_conf_dir}/routes.yaml":
            ensure => file,
            source => 'puppet:///modules/puppet/routes.yaml',
        }
    }

    file { "${puppet::params::puppet_conf_dir}/fileserver.conf":
        ensure => file,
        content => template('puppet/fileserver.conf'),
    }

    # Manage everything but the content of these.  Content will be managed
    # directly in git.
    file { ['/etc/puppet/auth.conf']:
    }

    # All other puppet configuration files are managed via GIT 'in place'.  If
    # others are to be managed here, do the following for each:
    #       To remove the file from the index (i.e., stop tracking):
    #       git rm --cached FILE
    #
    #       Ignore the deployed file:
    #       vim .gitignore; git add -p .gitignore
    #

    iptables::tcp_port {
        'puppetmaster': port => '8140';
    }

#   # A custom service unit file is installed to alter default policy
#   # regarding restarting after exiting.  See unit source for more details.
#
#   NOTE: If this block is resurrected, it needs to also manage enable/running
#   parms based on $use_passenger.
#
#   systemd::unit { 'puppetmaster.service':
#       source  => 'puppet:///modules/puppet/puppetmaster.service',
#       before  => Service[$puppet::params::server_services],
#       notify  => Service[$puppet::params::server_services],
#   }

    service { $puppet::params::server_services:
        enable      => (! $use_passenger and $enable),
        ensure      => $use_passenger ? {
            true    => stopped,
            default => $ensure,
        },
            hasrestart  => true,
            hasstatus   => true,
        }

}
