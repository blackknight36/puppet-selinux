# modules/sigul/manifests/params.pp
#
# == Class: sigul::params
#
# Parameters for the sigul puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class sigul::params {

    case $::operatingsystem {
        Fedora: {

            # The Client, Bridge and Server are all provided by the same
            # package.
            $packages = 'sigul'

            $bridge_services = 'sigul_bridge'
            $client_services = 'sigul_client'
            $server_services = 'sigul_server'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
