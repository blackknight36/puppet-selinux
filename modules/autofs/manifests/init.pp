# modules/autofs/manifests/init.pp
#
# Synopsis:
#       Configures a host for the autofs service.
#
# Parameters:
#       NONE


class autofs {

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

    if $::operatingsystemrelease < 19 {
        # Older versions of puppet and/or Fedora prevent the SELinux context
        # from actually changing, so don't even try as it otherwise generates
        # an endless stream of tagmail.
        file { '/pub':
            ensure	=> link,
            target  => '/mnt/pub',
        }
    } else {
        file { '/pub':
            ensure	=> link,
            target  => '/mnt/pub',
            seluser => 'system_u',
            selrole => 'object_r',
            seltype => 'nfs_t',
        }
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
