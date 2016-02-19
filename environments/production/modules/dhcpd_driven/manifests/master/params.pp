# modules/dhcpd_driven/manifests/master/params.pp
#
# == Class: dhcpd_driven::master::params
#
# Parameters for the dhcpd_driven::master puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dhcpd_driven::master::params {

    case $::operatingsystem {
        'Fedora': {

            $packages = [
                'dhcpd-driven-master',
            ]
            # service is provided by httpd or similar

        }

        default: {
            fail ("dhcpd_driven::master is not yet supported on ${::operatingsystem}.")
        }

    }

}
