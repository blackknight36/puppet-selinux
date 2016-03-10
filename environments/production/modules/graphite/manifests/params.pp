class graphite::params {

    case $::operatingsystem {
        'Fedora': {

            if $::operatingsystemrelease < '22' {
                notify{'oldfedora':
                    message => "The ${module_name} module is not supported on Fedora < 21.  Please upgrade your operating system.",
                }
            }
            else {
                $packages = ['graphite-web', 'python-carbon']
                $services = ['carbon-cache']
                $graphite_secret_key = hiera('graphite_secret_key', 'UNSAFE_DEFAULT')

                $db_sync_cmd = '/usr/lib/python2.7/site-packages/graphite/manage.py syncdb --noinput'
           }
        }

        default: {
            fail ("${title} is not supported on ${::operatingsystem}.")
        }
    }

}

