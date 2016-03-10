class collectd::params {

    case $::operatingsystem {
        'Fedora': {

            if $::operatingsystemrelease < '21' {
                notify{'oldfedora':
                    message => "The ${module_name} module is not supported on Fedora < 21.  Please upgrade your operating system.",
                }
            }
            else {
                $client_packages = ['collectd', 'collectd-lvm']
                $client_services = ['collectd']
                $client_template = 'collectd/collectd-client.conf.erb'
                $server_services = ['collectd']
                $server_packages = ['collectd']
                $server_template = 'collectd/collectd-server.conf.erb'

                selboolean { 'collectd_tcp_network_connect':
                    value => 'on',
                }
           }
        }

        default: {
            fail ("${title} is not supported on ${::operatingsystem}.")
        }
    }

}

