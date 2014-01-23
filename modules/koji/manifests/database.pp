# modules/koji/manifests/database.pp
#
# Synopsis:
#       Configures a host to provide the koji database.
#
# Parameters:
#       Name__________  Notes_  Description_______________________________
#
#       config_source   1       configuration source for the Koji database
#
# Notes:
#       This class presently assumes a PostgreSQL database.  Additional
#       manual work is required to create the database, import the schema and
#       provide the initial population.  See the following for more details:
#       https://fedoraproject.org/wiki/Koji/ServerHowTo#PostgreSQL_Server


class koji::database ( $config_source ) {

    class { 'postgresql::server':
        hba_conf    => 'puppet:///private-host/postgresql/pg_hba.conf',
    }

    # NB: This config is hardly needed.  Presently, the only requirement would
    # be to adjust listen_addresses and even that is only needed when the
    # Koji-Hub runs a host distinct from that providing the database.
    postgresql::config { 'postgresql.conf':
        source  => $config_source,
    }

}
