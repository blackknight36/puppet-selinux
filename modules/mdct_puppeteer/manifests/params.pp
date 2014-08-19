# modules/mdct_puppeteer/manifests/params.pp
#
# == Class: mdct_puppeteer::params
#
# Parameters for the mdct_puppeteer puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class mdct_puppeteer::params {

    case $::operatingsystem {
        Fedora: {

            $packages = [
                'mdct-puppeteer',
            ]

        }

        default: {
            fail ("The mdct_puppeteer module is not yet supported on ${::operatingsystem}.")
        }

    }

}
