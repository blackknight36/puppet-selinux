# modules/autofs/manifests/params.pp
#
# Synopsis:
#       Parameters for the autofs puppet module.


class autofs::params {

    case $::operatingsystem {
        'Fedora': {

            $packages = [
                'autofs',
            ]
            $service_name = 'autofs'

        }

        default: {
            fail ("The autofs module is not yet supported on ${operatingsystem}.")
        }

    }

}
