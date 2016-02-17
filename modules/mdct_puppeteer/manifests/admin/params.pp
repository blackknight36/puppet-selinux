# modules/mdct_puppeteer/manifests/admin/params.pp
#
# == Class: mdct_puppeteer::admin::params
#
# Parameters for the mdct_puppeteer::admin puppet sub-module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class mdct_puppeteer::admin::params {

    case $::operatingsystem {
        'Fedora': {

            $packages = [
                'mdct-puppeteer-admin',
            ]

        }

        default: {
            fail ("The mdct_puppeteer module is not yet supported on ${::operatingsystem}.")
        }

    }

}
