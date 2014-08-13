# modules/autofs/manifests/init.pp
#
# == Class: autofs
#
# Configures a host for the autofs service.
#
# === Parameters
#
# None
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class autofs {

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
