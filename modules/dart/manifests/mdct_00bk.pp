# modules/dart/manifests/mdct_00bk.pp
#
# Synopsis:
#       Bacula backup system (director & storage daemons)
#
# Contact:
#       John Florian

class dart::mdct_00bk inherits dart::abstract::guarded_server_node {

    include '::network'

    network::interface { 'ens32':
        template   => 'static',
        ip_address => '10.201.64.1',
        netmask    => '255.255.252.0',
        gateway    => '10.201.67.254',
        stp        => 'no',
    }

    network::interface { 'ens34':
        template   => 'static',
        ip_address => '192.168.1.7',
        netmask    => '255.255.255.0',
        stp        => 'no',
    }

    file { '/storage':
        ensure  => directory,
    }

    mount { '/storage':
        ensure  => 'mounted',
        atboot  => true,
        device  => '/dev/BackupVG/lvol1',
        fstype  => 'auto',
        options => '_netdev,defaults',
        require => File['/storage'],
    }

    include 'iscsi::initiator'

#    class { 'postgresql::server':
#        hba_conf    => 'puppet:///private-host/postgresql/pg_hba.conf',
#    }

    class { 'jaf_bacula::client':
        dir_name   => $dart::params::bacula_dir_name,
        dir_passwd => 'Aq3b8OdDuJ4Z6pmbsK7tJNRvPSMosspucxCEJ4vFNxAz',
        mon_name   => $dart::params::bacula_mon_name,
        mon_passwd => 'Ojx6xUeoCuBymMWsB6RCutwlEKydA8ZpKPJaXHxi6eTn',
    }

    class { 'jaf_bacula::console':
        dir_address => $dart::params::bacula_dir_fqdn,
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => $dart::params::bacula_dir_passwd,
    }

    class { 'jaf_bacula::storage_daemon':
        dir_name       => $dart::params::bacula_dir_name,
        mon_name       => $dart::params::bacula_mon_name,
        mon_passwd     => $dart::params::bacula_mon_passwd,
        sd_name        => $dart::params::bacula_sd_name,
        sd_passwd      => $dart::params::bacula_sd_passwd,
        sd_archive_dev => '/storage/backup',
    }

    class { 'jaf_bacula::director':
        dir_conf      => template('dart/bacula/director.conf'),
        pgpass_source => 'puppet:///private-host/.pgpass',
#        require         => Class['postgresql::server'],
    }

    jaf_bacula::director::inclusion {
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
