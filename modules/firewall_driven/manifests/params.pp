# modules/firewall_driven/manifests/params.pp
#
# == Class: firewall_driven::params
#
# Parameters for the firewall_driven puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class firewall_driven::params {

    case $::operatingsystem {
        Fedora: {

            $master_packages = [
                'firewall-driven-master',
            ]

        }

        default: {
            fail ("The firewall_driven module is not yet supported on ${::operatingsystem}.")
        }

    }

}
