# modules/firewall_driven/manifests/master/params.pp
#
# == Class: firewall_driven::master::params
#
# Parameters for the firewall_driven::master puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class firewall_driven::master::params {

    case $::operatingsystem {
        'Fedora': {

            $packages = [
                'firewall-driven-master',
            ]
            # service is provided by httpd or similar

        }

        default: {
            fail ("firewall_driven::master is not yet supported on ${::operatingsystem}.")
        }

    }

}
