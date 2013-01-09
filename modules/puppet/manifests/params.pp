# modules/puppet/manifests/params.pp
#
# Synopsis:
#       Parameters for the puppet module that manages puppet itself.
#


class puppet::params {

    case $::operatingsystem {
        Fedora: {
            $client_packages = [ 'puppet', ]
            $server_packages = [ 'puppet-server', 'puppet-tools', ]

            if versioncmp($puppetversion, '3') > 0 {
                $client_service_name = 'puppetagent'
            } else {
                $client_service_name = 'puppet'
            }

            $server_service_name = 'puppetmaster'
        }

        default: {
            fail ("The puppet module is not yet supported on ${operatingsystem}.")
        }

    }

}
