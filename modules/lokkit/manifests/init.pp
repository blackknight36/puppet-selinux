# modules/lokkit/manifests/init.pp
#
# Synopsis:
#       Configures a host for lokkit use.
#
# Parameters:
#       NONE
#
# Requires:
#       $lokkit_disabled                   Set to 'true' to disable typical
#                                          iptables management via lokkit.
#
# Example usage:
#
#       include lokkit

class lokkit {

    package { 'system-config-firewall-base':
        ensure	=> installed,
    }

    if  $operatingsystem == 'Fedora' and
        $operatingsystemrelease == 'Rawhide' or
        $operatingsystemrelease >= 18
    {
        package { 'firewall-config':
            ensure	=> absent,
        }

        package { 'firewalld':
            ensure	=> absent,
            require => Package['firewall-config'],
        }
    }

}
