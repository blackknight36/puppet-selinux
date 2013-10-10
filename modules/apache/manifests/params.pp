# modules/apache/manifests/params.pp
#
# Synopsis:
#       Parameters for the apache puppet module.


class apache::params {

    case $::operatingsystem {
        Fedora: {

            $packages = [
                'httpd',
            ]
            $service_name = 'httpd'

            $bool_can_network_connect_db = 'httpd_can_network_connect_db'
            $bool_use_nfs = 'httpd_use_nfs'

        }

        default: {
            fail ("The apache module is not yet supported on ${::operatingsystem}.")
        }

    }

}
