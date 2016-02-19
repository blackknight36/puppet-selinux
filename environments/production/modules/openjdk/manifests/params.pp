# modules/openjdk/manifests/params.pp
#
# == Class: openjdk::params
#
# Parameters for the openjdk puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class openjdk::params {

    case $::operatingsystem {
        'Fedora': {

            $packages_1_7_0 = 'java-1.7.0-openjdk-headless'
            $packages_1_8_0 = 'java-1.8.0-openjdk-headless'

        }

        default: {
            fail ("The openjdk module is not yet supported on ${::operatingsystem}.")
        }

    }

}
