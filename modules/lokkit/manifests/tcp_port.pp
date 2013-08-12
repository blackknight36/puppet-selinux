# modules/lokkit/manifests/tcp_port.pp
#
# Synopsis:
#       Opens or closes a TCP port in iptables via lokkit.
#
# Parameters:
#       name:           The name of the TCP port to be managed.
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
#       lokkit::tcp_port { "ssh":
#           ensure  => "open",
#           port    => "22",
#       }


define lokkit::tcp_port ($ensure="open", $port) {

    if $lokkit::managed_host == true {

        case $ensure {

            "closed": {
                # The lokkit executable itself lacks this feature.
                fail("Closing ports is not yet supported.")
            }

            "open": {
                exec { "open-${name}-tcp-port":
                    command => "lokkit --port=${port}:tcp",
                    unless  => "grep -q -- '-A INPUT .* -p tcp --dport ${port} -j ACCEPT' /etc/sysconfig/iptables",
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
