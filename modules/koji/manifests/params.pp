# modules/koji/manifests/params.pp
#
# Synopsis:
#       Parameters for the koji puppet module.


class koji::params {

    case $::operatingsystem {
        Fedora: {

            $cli_packages = [
                'koji',
            ]
            $hub_packages = [
                'koji-hub',
            ]
            $kojira_packages = [
                'koji-utils',
            ]
            $web_packages = [
                'koji-web',
            ]
            $kojira_service_name = 'kojira'

        }

        default: {
            fail ("The koji module is not yet supported on ${::operatingsystem}.")
        }

    }

}
