# modules/lyx/manifests/params.pp
#
# == Class: lyx::params
#
# Parameters for the lyx puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class lyx::params {

    case $::operatingsystem {
        'Fedora': {

            $packages = [
                'lyx',
            ]
        }

        default: {
            fail ("The lyx module is not yet supported on ${::operatingsystem}.")
        }

    }

}
