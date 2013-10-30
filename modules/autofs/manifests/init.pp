# modules/autofs/manifests/init.pp
#
# Synopsis:
#       Configures a host for the autofs service.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       legacy          1       Treat host as a legacy host.
#
# Notes:
#
#       1. Default is true (for backwards compatibility), but all new host
#       builds should endeavor to use dart::subsys::autofs::common instead
#       which will set up the same traditional auto-mounts, but in a way that
#       is much more flexible and future-proof.


class autofs ( $legacy=true ) {

    include 'autofs::params'

    package { $autofs::params::packages:
        ensure  => installed,
        notify  => Service[$autofs::params::service_name],
    }

    file { '/etc/auto.master.d/':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        require => Package[$autofs::params::packages],
    }

    # TODO: make unconditional when all legacy cases have been transitioned
    if ! $legacy {

        concat { 'autofs_master_map':
            path    => '/etc/auto.master',
            notify  => Service[$autofs::params::service_name],
            require => File['/etc/auto.master.d/'],
        }

        # Mimic the Fedora defaults.
        concat::fragment{ 'autofs_master_map_prefix':
            target  => 'autofs_master_map',
            order   => 0,
            source  => 'puppet:///modules/autofs/auto.master',
        }

    }

    service { $autofs::params::service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        require     => [
            Class['authconfig'],
            Class['nfs::rpcidmapd'],
        ],
    }

}
