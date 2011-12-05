# modules/postgresql/manifests/classes/server.pp
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
# Example usage:
#
#       include postgresql::server

class postgresql::server {

    package { 'postgresql-server':
	ensure	=> installed,
    }

    if $operatingsystemrelease >= 16 {
        $postgresql_initdb_cmd = 'postgresql-setup initdb'
    } else {
        $postgresql_initdb_cmd = 'service postgresql initdb'
    }
    exec { 'postgresql-initdb':
        command => $postgresql_initdb_cmd,
        # This ensures the initdb is run once only.  Upon package
        # installation, the data directory is empty.  PG_VERSION (among many
        # other files) will appear once initdb has been run.
        creates => '/var/lib/pgsql/data/PG_VERSION',
        require => Package['postgresql-server'],
    }

   file { '/var/lib/pgsql/data/pg_hba.conf':
        group	=> 'postgres',
        mode    => 600,
        owner   => 'postgres',
        require => [
            Exec['postgresql-initdb'],
            Package['postgresql-server'],
        ],
        seluser => 'unconfined_u',
        selrole => 'object_r',
        seltype => 'postgresql_db_t',
        source  => [
            'puppet:///private-host/postgresql/pg_hba.conf',
            'puppet:///private-domain/postgresql/pg_hba.conf',
            'puppet:///modules/postgresql/pg_hba.conf',
        ],
    }

    service { 'postgresql':
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec['postgresql-initdb'],
            Package['postgresql-server'],
        ],
        subscribe	=> [
            File['/var/lib/pgsql/data/pg_hba.conf'],
        ],
    }

}
