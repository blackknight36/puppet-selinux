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
            # what stability means or why it's a good thing.  See:
            # https://tickets.puppetlabs.com/browse/PUP-1200
            if $::operatingsystemrelease >= 19 and
               versioncmp($puppetversion, '3.1.1') >= 0 and
               versioncmp($puppetversion, '3.4.0') < 0 {
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
