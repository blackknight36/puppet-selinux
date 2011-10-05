# /etc/puppet/modules/lokkit/manifests/definitions/tcp_port.pp
#
# Synopsis:
#       Installs a web-site configuration file for the Apache web server.
#
# Parameters:
#       name:           The name of the TCP port to be managed.
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
#       lokkit::tcp_port { "ssh":
#           ensure  => "open",
#           port    => "22",
#       }


define lokkit::tcp_port ($ensure="open", $port) {

    if $lokkit_disabled == "true" {
        info("Disabled via \$lokkit_disabled.")
    } else {

        case $ensure {

            "closed": {
                # The lokkit executable itself lacks this feature.
                fail("Closing ports is not yet supported.")
            }

            "open": {
                exec { "open-${name}-tcp-port":
                    command => "lokkit --port=${port}:tcp",
                    unless  => "grep -q -- '-A INPUT .* -p tcp --dport ${port} -j ACCEPT' /etc/sysconfig/iptables",
                    require => Package["system-config-firewall-base"],
                }
            }

            default: {
                fail("\$ensure must be either \"open\" or \"closed\".")
            }

        }

    }

}
