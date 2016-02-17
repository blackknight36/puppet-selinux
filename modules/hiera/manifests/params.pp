# modules/hiera/manifests/params.pp
#
# == Class: hiera::params
#
# Parameters for the hiera puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>


class hiera::params {

    case $::operatingsystem {
        'Fedora': {

            $packages = 'hiera'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
