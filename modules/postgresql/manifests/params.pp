# modules/postgresql/manifests/params.pp
#
# Synopsis:
#       Parameters for the postgresql puppet module.


class postgresql::params {

    case $::operatingsystem {
        Fedora: {

            $server_packages = [
                'postgresql-contrib',
                'postgresql-server',
            ]
            $service_name = 'postgresql'

            if $::operatingsystemrelease >= 16 {
                $initdb_cmd = 'postgresql-setup initdb'
            } else {
                $initdb_cmd = 'service postgresql initdb'
            }

        }

        default: {
            fail ("The postgresql module is not yet supported on ${::operatingsystem}.")
        }

    }

}
