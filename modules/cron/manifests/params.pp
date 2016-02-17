# modules/cron/manifests/params.pp
#
# == Class: cron::params
#
# Parameters for the cron puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class cron::params {

    case $::operatingsystem {
        'Fedora': {

            $packages = [
                'cronie',
            ]
            $service_name = 'crond'

        }

        default: {
            fail ("The cron module is not yet supported on ${::operatingsystem}.")
        }

    }

}
