# modules/logwatch/manifests/params.pp
#
# == Class: logwatch::params
#
# Parameters for the logwatch puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class logwatch::params {

    case $::operatingsystem {
        Fedora: {

            $packages = 'logwatch'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
