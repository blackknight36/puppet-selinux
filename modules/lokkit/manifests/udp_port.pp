# modules/lokkit/manifests/udp_port.pp
#
# Synopsis:
#       Configures iptables to open/close a specific UDP port.
#
# Parameters:
#       name:           The name of the UDP port to be managed.
#       ensure:         Either "open" (default) or "closed".
#       port:           Number or name of service port.
#
# Requires:
#       Class["lokkit"]
#
# Example usage:
#
#       include lokkit
#
#       lokkit::udp_port { "domain":
#           ensure  => "open",
#           port    => "53",
#       }


define lokkit::udp_port ($ensure="open", $port) {

    if $lokkit_disabled == "true" {
        info("Disabled via \$lokkit_disabled.")
    } else {

        case $ensure {

            "closed": {
                # The lokkit executable itself lacks this feature.
                fail("Closing ports is not yet supported.")
            }

            "open": {
                exec { "open-${name}-udp-port":
                    command => "lokkit --port=${port}:udp",
                    unless  => "grep -q -- '-A INPUT .* -p udp --dport ${port} -j ACCEPT' /etc/sysconfig/iptables",
                    require => Package["system-config-firewall-base"],
                }
            }

            default: {
                fail("\$ensure must be either \"open\" or \"closed\".")
            }

        }

    }

}
