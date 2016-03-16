# modules/openjdk/manifests/params.pp
#
# == Class: openjdk::params
#
# Parameters for the openjdk puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   Michael Watters <michael.watters@dart.biz>


class openjdk::params {

    case $::operatingsystem {
        'Fedora': {

            $packages_1_7_0 = 'java-1.7.0-openjdk-headless'
            $packages_1_8_0 = 'java-1.8.0-openjdk-headless'

            if $::operatingsystemrelease >= '22' {
                $ws_packages = 'java-1.8.0-openjdk'
            }
            else {
                $ws_packages = undef
            }

        }

        default: {
            fail ("${module_name} module is not yet supported on ${::operatingsystem}.")
        }

    }

}
