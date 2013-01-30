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
# Requires:
#       NONE
#
# Example Usage:
#
#       class {'network':
#            network_manager => true,
#       }

class network ($network_manager=false) {

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
