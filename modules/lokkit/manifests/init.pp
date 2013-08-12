# modules/lokkit/manifests/init.pp
#
# Synopsis:
#       Configures a host for lokkit use.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       managed_host    true            Set to false if iptables/ip6tables is
#                                       to be managed independently.  This
#                                       effectively makes all lokkit::tcp_port
#                                       and lokkit::udp_port statements
#                                       a no-op for that host.
#
# Example Usage:
#
#       class { 'lokkit':
#           managed_host => true,
#       }


class lokkit ($managed_host) {

    package { 'system-config-firewall-base':
        ensure  => installed,
    }

    # firewalld is used exclusively of iptables.  We require the latter.
    if  $operatingsystem == 'Fedora' and
        $operatingsystemrelease == 'Rawhide' or
        $operatingsystemrelease >= 18
    {
        yum::remove { 'firewalld':
        }
    }

}
