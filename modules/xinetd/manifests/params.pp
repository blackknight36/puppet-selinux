# modules/xinetd/manifests/params.pp
#
# == Class: xinetd::params
#
# Parameters for the xinetd puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class xinetd::params {

    case $::operatingsystem {
        Fedora: {

            $packages = [
                'xinetd',
            ]
            $service_name = 'xinetd'

        }

        default: {
            fail ("The xinetd module is not yet supported on ${::operatingsystem}.")
        }

    }

}
