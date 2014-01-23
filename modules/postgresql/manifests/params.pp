# modules/postgresql/manifests/params.pp
#
# == Class: postgresql::params
#
# Parameters for the postgresql puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class postgresql::params {

    case $::operatingsystem {

        Fedora: {

            $client_packages = [
                'postgresql',
            ]
            $server_packages = [
                'postgresql-server',
            ]
            $server_services = [
                'postgresql',
            ]

            if $::operatingsystemrelease >= 16 {
                $initdb_cmd = 'postgresql-setup initdb'
            } else {
                $initdb_cmd = 'service postgresql initdb'
            }

        }

        default: {
            fail ("The postgresql module is not yet supported on $::operatingsystem.")
        }

    }

}
