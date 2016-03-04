# modules/openssl/manifests/params.pp
#
# Synopsis:
#       Parameters for the openssl puppet module.
#
# === Authors
#
#   Michael Watters <michael.watters@dart.biz>

class openssl::params {

    case $::operatingsystem {
        'Fedora': {

            if $::operatingsystemrelease < '21' {
                notify{'oldfedora':
                    message => "The ${module_name} module is not supported on Fedora < 21.  Please upgrade your operating system.",
                }
            }
            else {
                $openssl_packages = ['openssl', 'ca-certificates']
            }
        }

        'CentOS': {
            $openssl_packages = ['openssl']
        }

        default: {
            fail ("${title} is not supported on ${::operatingsystem}.")
        }

    }

}
