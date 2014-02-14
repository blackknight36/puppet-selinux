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

            # Apparently the brilliant packagers at puppetlabs have no clue
            # what stability means or why it's a good thing.
            if versioncmp($puppetversion, '3.1') < 0 or
               versioncmp($puppetversion, '3.4.0') >= 0 {
                $client_service_name = 'puppet'
            } else {
                $client_service_name = 'puppetagent'
            }

            $server_service_name = 'puppetmaster'
        }

        default: {
            fail ("The puppet module is not yet supported on ${operatingsystem}.")
        }

    }

}
