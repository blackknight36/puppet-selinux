# /etc/puppet/modules/postgresql-server/manifests/init.pp

# ASSUMPTIONS:
# This class was developed to support bacula only.  Additional work will be
# required to make it more generic.  For new installations, you must still
# execute 'service postgresql initdb' manually to initialize the cluster.

class postgresql-server {

    # The client isn't required here, but is typically desired for
    # administration purposes.
    package { "postgresql":
	ensure	=> installed,
    }

    package { "postgresql-server":
	ensure	=> installed,
    }

   # TODO: This file contains an entry for the bacula user.  The bacula-server
   # class should be inserting this line!
   file { "/var/lib/pgsql/data/pg_hba.conf":
       # don't forget to verify these!
       group	=> "postgres",
       mode    => 600,
       owner   => "postgres",
       require => Package["postgresql-server"],
       source  => "puppet:///postgresql-server/pg_hba.conf",
   }

    service { "postgresql":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Package["postgresql-server"],
        ],
       subscribe	=> [
           File["/var/lib/pgsql/data/pg_hba.conf"],
       ]
    }

}
