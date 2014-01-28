# modules/dhcpd_driven/manifests/params.pp
#
# == Class: dhcpd_driven::params
#
# Parameters for the dhcpd_driven puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dhcpd_driven::params {

    case $::operatingsystem {
        Fedora: {

            $server_packages = [
                'dhcpd-driven-server',
            ]

        }

        default: {
            fail ("The dhcpd_driven module is not yet supported on ${::operatingsystem}.")
        }

    }

}
