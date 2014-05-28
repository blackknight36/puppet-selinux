# modules/dart/manifests/mdct_00bk.pp
#
# Synopsis:
#       Bacula backup system (director & storage daemons)
#
# Contact:
#       John Florian

class dart::mdct_00bk inherits dart::abstract::guarded_server_node {

    class { 'puppet::client':
    }

    class { 'bacula::console':
        dir_address => $dart::params::bacula_dir_fqdn,
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => $dart::params::bacula_dir_passwd,
    }

    class { 'bacula::director':
        dir_conf        => template('dart/bacula/director.conf'),
        pgpass_source   => 'puppet:///private-host/.pgpass',
    }

    class { 'bacula::storage_daemon':
        dir_name        => $dart::params::bacula_dir_name,
        mon_name        => $dart::params::bacula_mon_name,
        mon_passwd      => $dart::params::bacula_mon_passwd,
        sd_name         => $dart::params::bacula_sd_name,
        sd_passwd       => $dart::params::bacula_sd_passwd,
        sd_archive_dev  => '/storage/backup',
    }

    class { 'postgresql::server':
        hba_conf    => 'puppet:///private-host/postgresql/pg_hba.conf',
    }

    bacula::director::inclusion {
        'clients':
            content => template('dart/bacula/clients.conf');
        'file-sets':
            content => template('dart/bacula/file-sets.conf');
        'jobs':
            content => template('dart/bacula/jobs.conf');
        'schedules':
            content => template('dart/bacula/schedules.conf');
    }

}
