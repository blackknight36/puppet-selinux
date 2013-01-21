# modules/rpcidmapd/manifests/init.pp
#
# Synopsis:
#       Configures a host to run the NFS ID Mapper Daemon.
#
# Parameters:
#   NONE


class rpcidmapd {

    # Stage => early

    include rpcidmapd::params

    package { $rpcidmapd::params::packages:
        ensure  => installed,
        notify  => Service[$rpcidmapd::params::service_name],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$rpcidmapd::params::service_name],
        notify      => Service[$rpcidmapd::params::service_name],
        subscribe   => Package[$rpcidmapd::params::packages],
    }

    file { '/etc/idmapd.conf':
        source      => 'puppet:///modules/rpcidmapd/idmapd.conf',
    }

    service { $rpcidmapd::params::service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
