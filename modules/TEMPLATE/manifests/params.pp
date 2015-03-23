# modules/MODULE_NAME/manifests/params.pp
#
# == Class: MODULE_NAME::params
#
# Parameters for the MODULE_NAME puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>


class MODULE_NAME::params {

    case $::operatingsystem {
        Fedora: {

            $packages = 'PACKAGE_NAME'
            $packages = [
                'PACKAGE_NAME',
            ]

            $services = 'SERVICE_NAME'
            $services = [
                'SERVICE_NAME',
            ]

            # Hint:
            #   sudo semanage boolean  --list | grep MODULE_NAME
            if $::operatingsystemrelease < 18 {
                $bool_name1 = 'allow_httpd_anon_write'
            } else {
                $bool_name1 = 'httpd_anon_write'
            }
            $bool_name2 = 'httpd_can_network_connect'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
