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


class puppet::database {

    include 'puppet::params'

    package { $puppet::params::db_packages:
        ensure  => installed,
        notify  => Service[$puppet::params::db_services],
    }

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

    iptables::tcp_port {
        'puppet_database':  port => '8081';
    }

    service { $puppet::params::db_services:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
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
