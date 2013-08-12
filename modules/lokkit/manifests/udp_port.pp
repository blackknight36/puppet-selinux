# modules/lokkit/manifests/udp_port.pp
#
# Synopsis:
#       Opens or closes a UDP port in iptables via lokkit.
#
# Parameters:
#       name:           The name of the UDP port to be managed.
#       ensure:         Either "open" (default) or "closed".
#       port:           Number or name of service port.
#
# Requires:
#       Class["lokkit"]
#
# Example Usage:
#
#       class { 'lokkit':
#           managed_host => true,
#       }
#
#       lokkit::udp_port { "domain":
#           ensure  => "open",
#           port    => "53",
#       }


define lokkit::udp_port ($ensure="open", $port) {

    if $lokkit::managed_host == true {

        case $ensure {

            "closed": {
                # The lokkit executable itself lacks this feature.
                fail("Closing ports is not yet supported.")
            }

            "open": {
                exec { "open-${name}-udp-port":
                    command => "lokkit --port=${port}:udp",
                    unless  => "grep -q -- '-A INPUT .* -p udp --dport ${port} -j ACCEPT' /etc/sysconfig/iptables",
                    require => Class['lokkit'],
                }
            }

            default: {
                fail("\$ensure must be either \"open\" or \"closed\".")
            }

        }

    } else {
        notice "iptables management via lokkit is disabled on $fqdn via lokkit::managed_host."
    }

}
