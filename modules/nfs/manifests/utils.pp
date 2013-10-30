# modules/nfs/manifests/utils.pp
#
# == Class: nfs::utils
#
# Configures a host to run the NFS ID Mapper daemon.
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

}
