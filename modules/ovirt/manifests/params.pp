# modules/ovirt/manifests/params.pp
#
# == Class: ovirt::params
#
# Parameters for the ovirt puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class ovirt::params {

    case $::operatingsystem {
        Fedora: {

            $guest_packages = [
                'ovirt-guest-agent-common',
            ]
            $guest_service_name = 'ovirt-guest-agent'

        }

        default: {
            fail ("The ovirt module is not yet supported on ${::operatingsystem}.")
        }

    }

}
