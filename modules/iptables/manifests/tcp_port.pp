# modules/iptables/manifests/tcp_port.pp
#
# Synopsis:
#       Opens or closes a TCP port in iptables/ip6tables.
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


define iptables::tcp_port ($ensure='open', $port) {

    if $iptables::managed_host == true {

        case $ensure {

            'closed': {
                # The lokkit executable itself lacks this feature.
                fail('Closing ports is not yet supported.')
            }

            'open': {
                exec { "open-${name}-tcp-port":
                    command => "lokkit --port=${port}:tcp",
                    unless  => "grep -q -- '-A INPUT .* -p tcp --dport ${port} -j ACCEPT' /etc/sysconfig/iptables",
                    notify  => Service[$iptables::params::services],
                }
            }

            default: {
                fail('$ensure must be either "open" or "closed".')
            }

        }

    } else {
        notice("iptables management is disabled on $fqdn via \$iptables::managed_host.")
    }

}
