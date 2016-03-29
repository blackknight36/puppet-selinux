class collectd::params {

    case $::operatingsystem {
        'Fedora', 'CentOS': {

            if $::operatingsystem == 'Fedora' and $::operatingsystemrelease < '20' {
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
                    value      => 'on',
                    persistent => true,
                }
           }
        }

        default: {
            fail ("${module_name} is not supported on ${::operatingsystem}.")
        }
    }

}

