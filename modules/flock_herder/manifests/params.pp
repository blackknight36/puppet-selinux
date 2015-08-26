# modules/flock_herder/manifests/params.pp
#
# == Class: flock_herder::params
#
# Parameters for the flock_herder puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class flock_herder::params {

    case $::operatingsystem {

        Fedora: {
            $packages = 'flock-herder'
        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
