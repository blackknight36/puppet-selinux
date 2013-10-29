# modules/iptables/manifests/udp_port.pp
#
# Synopsis:
#       Opens or closes a UDP port in iptables/ip6tables.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       ensure          1       either 'open' or 'closed'
#
#       port                    number or name of service port
#
# Notes:
#
#       1. Default is 'open'.


define iptables::udp_port ($ensure='open', $port) {

    if $iptables::managed_host == true {

        case $ensure {

            'closed': {
                # The lokkit executable itself lacks this feature.
                fail('Closing ports is not yet supported')
            }

            'open': {
                exec { "open-${name}-udp-port":
                    command => "lokkit --port=${port}:udp",
                    unless  => "grep -q -- '-A INPUT .* -p udp --dport ${port} -j ACCEPT' /etc/sysconfig/iptables",
                    notify  => Service[$iptables::params::services],
                }
            }

            default: {
                fail('$ensure must be either "open" or "closed"')
            }

        }

    } else {
        notice("iptables management is disabled on $fqdn via \$iptables::managed_host.")
    }

}
