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
            $web_packages = [
                'koji-web',
            ]

        }

        default: {
            fail ("The koji module is not yet supported on ${::operatingsystem}.")
        }

    }

}
