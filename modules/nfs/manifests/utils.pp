# modules/nfs/manifests/utils.pp
#
# == Class: nfs::utils
#
# Manages the NFS utilities on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#   John Florian <john.florian@dart.biz>


class nfs::utils inherits ::nfs::params {

    package { $::nfs::params::utils_packages:
        ensure  => installed,
    }

    if $::nfs::params::pipefs_service {

        service { $::nfs::params::pipefs_service:
            ensure     => running,
            enable     => true,
            hasrestart => true,
            hasstatus  => true,
            provider   => systemd,
            before     => Service[$::nfs::params::idmap_service],
            notify     => Service[$::nfs::params::idmap_service],
        }

    }

}
