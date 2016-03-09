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
#   Michael Watters <michael.watters@dart.biz>


class nfs::utils inherits ::nfs::params {

    package { $::nfs::params::utils_packages:
        ensure  => installed,
    }

    if $::nfs::params::pipefs_service {

        $pipefs_ensure = $::nfs::params::pipefs_service_is_static ? {
            true => 'stopped',
            default => true,
        }

        $pipefs_enable = $::nfs::params::pipefs_service_is_static ? {
            true => undef,
            default => true,
        }

        service { $::nfs::params::pipefs_service:
            ensure     => $pipefs_ensure,
            enable     => $pipefs_enable,
            hasrestart => true,
            hasstatus  => true,
            provider   => systemd,
            before     => Service[$::nfs::params::idmap_service],
            notify     => Service[$::nfs::params::idmap_service],
        }

    }

}
