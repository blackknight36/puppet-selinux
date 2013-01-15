# modules/autofs/manifests/init.pp
#
# Synopsis:
#       Configures a host for the autofs service.
#
# Parameters:
#       NONE


class autofs {

    include authconfig
    include rpcidmapd

    include autofs::params

    package { $autofs::params::packages:
        ensure  => installed,
        notify  => Service[$autofs::params::service_name],
    }

    selinux::boolean { 'use_nfs_home_dirs':
        before      => Service[$autofs::params::service_name],
        persistent  => true,
        value       => on,
    }

    autofs::mount { 'home':
        source  => 'puppet:///modules/autofs/auto.home',
    }

    autofs::mount { 'master':
        source  => "puppet:///modules/autofs/${autofs::params::master_source}",
    }

    autofs::mount { 'mnt':
        source	=> 'puppet:///modules/autofs/auto.mnt',
    }

    autofs::mount { 'mnt-local':
        source  => [
            'puppet:///private-host/autofs/auto.mnt-local',
            'puppet:///private-domain/autofs/auto.mnt-local',
            'puppet:///modules/autofs/auto.mnt-local',
        ],
    }

    file { '/pub':
	    ensure	=> link,
        target  => '/mnt/pub',
    }

    service { $autofs::params::service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        require     => [
            Class['authconfig'],
            Class['rpcidmapd'],
        ],
    }

}
