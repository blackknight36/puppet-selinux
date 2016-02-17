# modules/picaps/manifests/params.pp
#
# Synopsis:
#       Parameters for the picaps puppet module.


class picaps::params {

    case $::operatingsystem {
        'Fedora': {

            $backup_packages = [
                'picaps-backup-agent',
            ]

        }

        default: {
            fail ("The picaps module is not yet supported on ${operatingsystem}.")
        }

    }

}
