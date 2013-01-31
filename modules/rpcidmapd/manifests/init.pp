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

    # Configuring the nfs kernel module like this is only necessary so long as
    # our NFS servers are Fedora < 16.  This works around a kernel bug on
    # older NFS servers.  Technical contact for this is Levi Harper.
    if $rpcidmapd::params::kernel_options != undef {
        file { '/etc/modprobe.d/nfs.conf':
            mode    => '0644',
            seltype => 'modules_conf_t',
            content => "$rpcidmapd::params::kernel_options\n",
        }
    }

    service { $rpcidmapd::params::service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
