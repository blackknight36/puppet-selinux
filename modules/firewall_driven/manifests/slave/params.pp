# modules/firewall_driven/manifests/slave/params.pp
#
# == Class: firewall_driven::slave::params
#
# Parameters for the firewall_driven::slave puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class firewall_driven::slave::params {

    case $::operatingsystem {
        'Fedora': {

            $packages = [
                'firewall-driven-slave',
            ]
            $service = 'firewall-driven-slave'
            $service_with_vlb = "${service}-with-vlan-bridge"

        }

        default: {
            fail ("firewall_driven::slave is not yet supported on ${::operatingsystem}.")
        }

    }

}
