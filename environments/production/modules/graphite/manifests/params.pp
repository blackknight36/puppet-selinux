class graphite::params {

    case $::operatingsystem {
        'Fedora': {

            if $::operatingsystemrelease < '22' {
                notify{'oldfedora':
                    message => "The ${module_name} module is not supported on Fedora < 21.  Please upgrade your operating system.",
                }
            }
            else {
                $packages = ['graphite-web']
           }
        }

        default: {
            fail ("${title} is not supported on ${::operatingsystem}.")
        }
    }

}

