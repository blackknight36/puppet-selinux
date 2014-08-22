# modules/dhcpd_driven/manifests/slave/params.pp
#
# == Class: dhcpd_driven::slave::params
#
# Parameters for the dhcpd_driven::slave puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dhcpd_driven::slave::params {

    case $::operatingsystem {
        Fedora: {

            $packages = [
                'dhcpd-driven-slave',
            ]
            $service = 'dhcpd-driven-slave'

        }

        default: {
            fail ("dhcpd_driven::slave is not yet supported on ${::operatingsystem}.")
        }

    }

}
