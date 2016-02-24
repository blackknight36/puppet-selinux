# modules/tsocks/manifests/params.pp
#
# == Class: tsocks::params
#
# Parameters for the tsocks puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class tsocks::params {

    case $::operatingsystem {
        'Fedora': {

            $packages = 'tsocks'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
