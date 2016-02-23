# modules/lvm_snapshot_tools/manifests/params.pp
#
# == Class: lvm_snapshot_tools::params
#
# Parameters for the lvm_snapshot_tools puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class lvm_snapshot_tools::params {

    case $::operatingsystem {

        'Fedora': {

            $packages = 'lvm-snapshot-tools'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
