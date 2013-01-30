# modules/network/manifests/init.pp
#
# Synopsis:
#       Configures network services on a host.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       network_manager false           If true, use NetworkManager instead of
#                                       legacy network service.
#
#       domain                          Name of domain.
#
#       name_servers    undef           List of IP addresses that provide DNS
#                                       name resolution.
#
# Requires:
#       NONE
#
# Example Usage:
#
#       class {'network':
#            network_manager    => true,
#            domain             => 'example.com',
#            name_servers       => ['192.168.1.1', '192.168.1.2']
#       }

class network ($network_manager=false, $domain, $name_servers=undef) {

    # initscripts is required regardless of whether NetworkManager is used.
    package { 'initscripts':
        ensure  => installed,
    }

    if $network_manager == true {
        $service = 'NetworkManager'
        package { ['NetworkManager']:
            ensure  => installed,
        }
    } else {
        $service = 'network'
        yum::remove { 'NetworkManager':
            before  => Service[$service],
            # It may be necessary to have the replacement installed prior to
            # removal of the conflicting package.
            require => Package['initscripts'],
        }
    }

    if $name_servers != undef {
        file { '/etc/resolv.conf':
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            seluser => 'system_u',
            selrole => 'object_r',
            seltype => 'etc_t',
            before  => Service[$service],
            content => template('network/resolv.conf'),
        }
    }

    # PITA reduction
    file { "/etc/network":
        ensure  => link,
        target  => "sysconfig/network-scripts/",
    }

    service { $service:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        require     => [
            Package['initscripts'],
        ],
    }

}
