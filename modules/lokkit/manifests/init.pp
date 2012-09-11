# modules/lokkit/manifests/init.pp
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

    if  $operatingsystem == "Fedora" and
        $operatingsystemrelease == 'Rawhide' or
        $operatingsystemrelease >= 13
    {
        package { "system-config-firewall-base":
            ensure	=> installed,
        }
    }

}
