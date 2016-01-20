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
            $mash_packages = [
                'mash',
                'repoview',
            ]
            $utils_packages = 'koji-utils'
            $web_packages = 'koji-web'

            $builder_services = 'kojid'
            $kojira_services = 'kojira'

            $admin_user = 'kojiadmin'
            $helpers_bin = '/usr/local/libexec/_shared_koji_helpers'
            $mash_dir = '/etc/mash'
            $mash_everything_bin = '/usr/local/bin/mash-everything'
            $mash_everything_conf = '/etc/mash/mash-everything.conf'
            $regen_repos_bin = '/usr/local/bin/regen-repos'
            $regen_repos_conf = '/etc/regen-repos.conf'
            $regen_repos_states = '/var/lib/regen-repos'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
