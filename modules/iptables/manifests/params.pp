# modules/iptables/manifests/params.pp
#
# Synopsis:
#       Parameters for the iptables puppet module.


class iptables::params {

    case $::operatingsystem {
        'Fedora': {

            if $::operatingsystemrelease < '16' {
                $packages = [
                    'iptables',
                    'iptables-ipv6',
                    'system-config-firewall-base',  # for lokkit
                ]
                $services = [
                    'iptables',
                    'ip6tables',
                ]
            } else {
                $packages = [
                    'iptables',
                    'system-config-firewall-base',  # for lokkit
                ]
                $services = [
                    'iptables',
                ]
            }
            if $::operatingsystemrelease == 'Rawhide' or
               $::operatingsystemrelease >= '18'
            {
                $conflicting_packages = [
                    'firewalld',
                ]
            } else {
                $conflicting_packages = [
                ]
            }

        }

        default: {
            fail ("The iptables module is not yet supported on ${::operatingsystem}.")
        }

    }

}
