# modules/postgresql/manifests/server.pp
#
# == Class: postgresql::server
#
# Configures a host as a PostgreSQL server.
#
# === Parameters
#
# [*hba_conf*]
#   Source URI of the pg_hba.conf file.
#
# === Notes
#
#   - This class will automatically initialize the database cluster if no
#   cluster already exists.
#
#   - This class will not open any firewall ports because there is a good
#   chance the database is to be accessible to the localhost only.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class postgresql::server ($hba_conf) {

    include 'postgresql::params'

    package { $postgresql::params::server_packages:
        ensure  => installed,
        notify  => Service[$postgresql::params::server_services],
    }

    exec { 'postgresql-initdb':
        command => $postgresql::params::initdb_cmd,
        # This ensures the initdb is run once only.  Upon package
        # installation, the data directory is empty.  PG_VERSION (among many
        # other files) will appear once the cluster has been initialized.
        creates => '/var/lib/pgsql/data/PG_VERSION',
        before  => Service[$postgresql::params::server_services],
        require => Package[$postgresql::params::server_packages],
    }

    postgresql::config { 'pg_hba.conf':
        require => Exec['postgresql-initdb'],
        source  => $hba_conf,
    }

    service { $postgresql::params::server_services:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
