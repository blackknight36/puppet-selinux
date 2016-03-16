# modules/openjdk/manifests/workstation.pp
#
# == Class: openjdk::workstation
#
# Manages openjdk packages for workstation nodes.  
#
# === Authors
#
#   Michael Watters <michael.watters@dart.biz>

class openjdk::workstation {

    include 'openjdk::params'

    case $::operatingsystem {
        'Fedora': {
            if $openjdk::params::ws_packages != undef {
                package { $openjdk::params::ws_packages:
                    ensure => installed,
                }
            }
        }

        default: {
            fail ("${module_name} is not yet supported on ${::operatingsystem}.")
        }

    }
}
