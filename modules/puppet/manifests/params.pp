# modules/puppet/manifests/params.pp
#
# == Class: puppet::params
#
# Parameters for the puppet puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#   John Florian <john.florian@dart.biz>


class puppet::params {

    case $::operatingsystem {

        Fedora: {

            ## Client ##
            # Apparently the brilliant packagers at puppetlabs have no clue
            # what stability means or why it's a good thing.  See:
            # https://tickets.puppetlabs.com/browse/PUP-1200
            if $::operatingsystemrelease >= 19 and
               versioncmp($puppetversion, '3.1.1') >= 0 and
               versioncmp($puppetversion, '3.4.0') < 0 {
                $client_services = [
                    'puppetagent',
                ]
            } else {
                $client_services = [
                    'puppet',
                ]
            }
            $client_packages = [
                'puppet',
            ]

            ## Database ##
            # Presently $db_packages are not shipped with Fedora, thus it is
            # necessary to configure the PuppetLabs FOSS repo as per:
            # http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#open-source-repositories
            $db_packages = [
                'puppetdb',
                'puppetdb-terminus',
            ]
            $db_services = [
                'puppetdb',
            ]

            ## Server ##
            $server_services = [
                'puppetmaster',
            ]
            $server_packages = [
                'puppet-server',
            ]

            ## Tools ##
            $tools_packages = [
                'puppet-tools',
            ]

        }

        default: {
            fail ("The puppet module is not yet supported on $::operatingsystem.")
        }

    }

}
