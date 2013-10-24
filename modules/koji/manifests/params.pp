# modules/koji/manifests/params.pp
#
# Synopsis:
#       Parameters for the koji puppet module.


class koji::params {

    case $::operatingsystem {
        Fedora: {

            $builder_packages = [
                'koji-builder',
            ]
            $cli_packages = [
                'koji',
            ]
            $hub_packages = [
                'koji-hub',
            ]
            $kojira_packages = [
                'koji-utils',
            ]
            $mash_packages = [
                'mash',
                'repoview',
            ]
            $web_packages = [
                'koji-web',
            ]
            $builder_service_name = 'kojid'
            $kojira_service_name = 'kojira'
            $our_mashes = '/etc/mash/ours'

        }

        default: {
            fail ("The koji module is not yet supported on ${::operatingsystem}.")
        }

    }

}
