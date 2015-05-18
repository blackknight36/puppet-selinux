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
            $hub_packages = [
                'koji-hub',
                'koji-hub-plugins',
            ]
            $kojira_packages = 'koji-utils'
            $mash_packages = [
                'mash',
                'repoview',
            ]
            $web_packages = 'koji-web'

            $builder_services = 'kojid'
            $kojira_services = 'kojira'

            $admin_user = 'kojiadmin'
            $helpers_bin = '/usr/local/libexec/_shared_koji_helpers'
            $mash_dir = '/etc/mash'
            $mash_everything_bin = '/usr/local/bin/mash-everything'
            $mash_everything_conf = '/etc/mash/mash-everything.conf'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
