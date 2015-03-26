# modules/koji/manifests/params.pp
#
# == Class: koji::params
#
# Parameters for the koji puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class koji::params {

    case $::operatingsystem {
        Fedora: {

            $builder_packages = 'koji-builder'
            $cli_packages = 'koji'
            $hub_packages = 'koji-hub'
            $kojira_packages = 'koji-utils'
            $mash_packages = [
                'mash',
                'repoview',
            ]
            $web_packages = 'koji-web'

            $builder_services = 'kojid'
            $kojira_services = 'kojira'

            $admin_user = 'kojiadmin'
            $our_mashes = '/etc/mash/ours'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
