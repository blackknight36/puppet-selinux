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

    # TODO: Perhaps should have a "define autofs::mount", especially given
    # seltype being unusual as bin_t instead of etc_t.
    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'bin_t',
        before      => Service[$autofs::params::service_name],
        notify      => Service[$autofs::params::service_name],
        subscribe   => Package[$autofs::params::packages],
    }

    file { '/etc/auto.home':
        source  => 'puppet:///modules/autofs/auto.home',
    }

    file { '/etc/auto.master':
        source  => "puppet:///modules/autofs/${autofs::params::master_source}",
    }

    file { "/etc/auto.mnt":
        source	=> 'puppet:///modules/autofs/auto.mnt',
    }

    file { '/etc/auto.mnt-local':
        source  => [
            'puppet:///private-host/autofs/auto.mnt-local',
            'puppet:///private-domain/autofs/auto.mnt-local',
            'puppet:///modules/autofs/auto.mnt-local',
        ],
    }

    file { '/pub':
	    ensure	=> link,
        target  => '/mnt/pub',
        seltype => 'default_t',
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
