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

        'CentOS': {
            $packages = undef
        }

        default: {
            notify {'unsupported':
                message => "${module_name}: operating system '${::operatingsystem}' is not supported by this module.",
            }
        }

    }

}
