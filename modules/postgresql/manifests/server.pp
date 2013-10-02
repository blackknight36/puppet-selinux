# modules/postgresql/manifests/server.pp
#
# Synopsis:
#       Configures a host as a PostgreSQL server.
#
# Parameters:
#       NONE
#
# Requires:
#       NONE
#
# Notes:
#       - This class will automatically initialize the database cluster if
#       there is none.
#       - This class currently will not open any firewall ports because there
#       is a good chance the database is to be accessible to the localhost
#       only.
#
# Example Usage:
#
#       include postgresql::server

class postgresql::server {

    include 'postgresql::params'

    package { $postgresql::params::server_packages:
        ensure  => installed,
        notify  => Service[$postgresql::params::service_name],
    }

    exec { 'postgresql-initdb':
        command => $postgresql::params::initdb_cmd,
        # This ensures the initdb is run once only.  Upon package
        # installation, the data directory is empty.  PG_VERSION (among many
        # other files) will appear once initdb has been run.
        creates => '/var/lib/pgsql/data/PG_VERSION',
        before  => Service[$postgresql::params::service_name],
        require => Package[$postgresql::params::server_packages],
    }

    postgresql::config { 'pg_hba.conf':
        require => Exec['postgresql-initdb'],
        source  => [
            'puppet:///private-host/postgresql/pg_hba.conf',
            'puppet:///private-domain/postgresql/pg_hba.conf',
            'puppet:///modules/postgresql/pg_hba.conf',
        ],
    }

    service { $postgresql::params::service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
