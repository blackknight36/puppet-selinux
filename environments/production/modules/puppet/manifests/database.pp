# modules/puppet/manifests/database.pp
#
# == Class: puppet::database
#
# Configures a host as a puppet database.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#   Michael Watters <michael.watters@dart.biz>


class puppet::database {

    include 'puppet::params'

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$puppet::params::db_services],
        notify      => Service[$puppet::params::db_services],
        subscribe   => Package[$puppet::params::db_packages],
    }

    package { $puppet::params::db_packages:
        ensure => installed,
        notify => Service[$puppet::params::db_services],
    }

    iptables::tcp_port {
        'puppet_database':  port => '8081';
    }

    $ssldir = $::operatingsystem ? {
        'Fedora' => '/var/lib/puppet/ssl',
        'CentOS' => '/etc/puppetlabs/puppet/ssl',
    }

    file { '/etc/puppetlabs/puppetdb/ssl/private.pem':
        ensure => file,
        owner  => 'puppetdb',
        group  => 'puppetdb',
        mode   => '0600',
        source => "${ssldir}/private_keys/${::fqdn}.pem",
    }

    file { '/etc/puppetlabs/puppetdb/ssl/public.pem':
        ensure => file,
        owner  => 'puppetdb',
        group  => 'puppetdb',
        mode   => '0600',
        source => "${ssldir}/certs/${::fqdn}.pem",
    }
    
    file { '/etc/puppetlabs/puppetdb/ssl/ca.pem':
        ensure => file,
        owner  => 'puppetdb',
        group  => 'puppetdb',
        mode   => '0600',
        source => "${ssldir}/certs/ca.pem",
    }

    service { $puppet::params::db_services:
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        # I've found cases where the agent reports:
        #   Error: Could not retrieve catalog from remote server: Error 400 on
        #       SERVER: Failed to submit 'replace facts' command for
        #       droopy.doubledog.org to PuppetDB at
        #       puppet.doubledog.org:8081: Connection refused - connect(2)
        # Restarting the DB alone wasn't enough; the master also had to be
        # restarted, hence:
        #
        # This didn't work.  May need to make systemd unit for the DB or make
        # the master require the DB.
        # notify      => Service[$puppet::params::server_services],
    }

}
