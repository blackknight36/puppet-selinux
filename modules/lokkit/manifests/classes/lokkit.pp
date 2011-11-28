# modules/lokkit/manifests/classes/lokkit.pp
#
# Synopsis:
#       Configures a host for lokkit use.
#
# Parameters:
#       NONE
#
# Requires:
#       $lokkit_disabled                   Set to "true" to disable typical
#                                          iptables management via lokkit.
#
# Example usage:
#
#       include lokkit

class lokkit {

    if $operatingsystem == "Fedora" and $operatingsystemrelease < 13 {
        package { "system-config-firewall-base":
            ensure	=> installed,
            name        => "system-config-firewall-tui",
        }
    } else {
        package { "system-config-firewall-base":
            ensure	=> installed,
        }
    }

}
