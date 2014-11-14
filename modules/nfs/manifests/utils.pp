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

    if $::operatingsystem == 'Fedora' and $::operatingsystemrelease == 20 {

        # Temporary kludge for FBZ# 1115179.
        package { 'libnfsidmap':
            ensure  => installed,
        }

        package { 'nfs-utils':
            ensure  => '1.3.0-2.2.fc20',
        }

    } else {

        package { $nfs::params::utils_packages:
            ensure  => installed,
        }

    }

}
