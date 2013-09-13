# modules/mock/manifests/params.pp
#
# Synopsis:
#       Parameters for the mock puppet module.


class mock::params {

    case $::operatingsystem {
        Fedora: {

            $packages = [
                'mock',
            ]

        }

        default: {
            fail ("The mock module is not yet supported on ${operatingsystem}.")
        }

    }

}
