# modules/mariadb/manifests/params.pp
#
# Synopsis:
#       Parameters for the mariadb puppet module.


class mariadb::params {

    case $::operatingsystem {
        Fedora: {

            $serverpackages = [
                'mariadb-server',
            ]
            $clientpackages = [
                'mariadb',
            ]
            $service_name = 'mysqld'

        }

        default: {
            fail ("The mariadb module is not yet supported on ${operatingsystem}.")
        }

    }

}
