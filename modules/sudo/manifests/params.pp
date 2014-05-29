# modules/sudo/manifests/params.pp
#
# == Class: sudo::params
#
# Parameters for the sudo puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class sudo::params {

    case $::operatingsystem {
        Fedora: {

            if $::operatingsystemrelease < 13 {
                fail ("The sudo module is not supported for Fedora < 13.")
            }

            $packages = [
                'sudo',
            ]

        }

        default: {
            fail ("The sudo module is not yet supported on ${::operatingsystem}.")
        }

    }

}
