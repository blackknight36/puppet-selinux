# modules/iscsi/manifests/params.pp
#
# == Class: iscsi::params
#
# Parameters for the iscsi puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class iscsi::params {

    case $::operatingsystem {
        'Fedora': {

            $packages = [
                'iscsi-initiator-utils',
            ]
            $service_name = [
                'iscsi.service',
            ]

        }

        default: {
            fail ("The iscsi module is not yet supported on ${::operatingsystem}.")
        }

    }

}
