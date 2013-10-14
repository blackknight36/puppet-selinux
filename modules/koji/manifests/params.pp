# modules/koji/manifests/params.pp
#
# Synopsis:
#       Parameters for the koji puppet module.


class koji::params {

    case $::operatingsystem {
        Fedora: {

            $cli_packages = [
                'koji',
            ]

        }

        default: {
            fail ("The koji module is not yet supported on ${::operatingsystem}.")
        }

    }

}
