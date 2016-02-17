# modules/rsync/manifests/params.pp
#
# == Class: rsync::params
#
# Parameters for the rsync puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class rsync::params {

    case $::operatingsystem {
        'Fedora': {

            $packages = [
                'rsync',
            ]
            $bool_export_all_ro = 'rsync_export_all_ro'

        }

        default: {
            fail ("The rsync module is not yet supported on ${::operatingsystem}.")
        }

    }

}
