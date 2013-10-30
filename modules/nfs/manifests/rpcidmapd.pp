# modules/nfs/manifests/rpcidmapd.pp
#
# == Class: nfs::rpcidmapd
#
# Configures a host to run the NFS ID Mapper daemon.
#
# === Parameters
#
# [*domain*]
#   Name of the NFS domain.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class nfs::rpcidmapd ($domain) {

    # Stage => early

    include 'nfs::params'
    include 'nfs::utils'

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$nfs::params::idmap_service],
        notify      => Service[$nfs::params::idmap_service],
        subscribe   => Package[$nfs::params::utils_packages],
    }

    file { '/etc/idmapd.conf':
        content => template('nfs/idmapd.conf'),
    }

    # Configuring the nfs kernel module like this is only necessary if the NFS
    # servers are Fedora < 16.  This works around a kernel bug on older NFS
    # servers.  Technical contact for this is Levi Harper.
    if $nfs::params::kernel_options != undef {
        file { '/etc/modprobe.d/nfs.conf':
            mode    => '0644',
            seltype => 'modules_conf_t',
            content => "$nfs::params::kernel_options\n",
        }
    }

    service { $nfs::params::idmap_service:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
