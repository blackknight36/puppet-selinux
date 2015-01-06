# modules/nfs/manifests/utils.pp
#
# == Class: nfs::utils
#
# Manages the NFS utilities on a host.
#
# === Parameters
#
# None.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class nfs::utils {

    include 'nfs::params'

    package { $nfs::params::utils_packages:
        ensure  => installed,
    }

    if $nfs::params::pipefs_service {

        service { $nfs::params::pipefs_service:
            ensure     => running,
            enable     => true,
            hasrestart => true,
            hasstatus  => true,
            provider   => systemd,
            before     => Service[$nfs::params::idmap_service],
            notify     => Service[$nfs::params::idmap_service],
        }

    }

}
