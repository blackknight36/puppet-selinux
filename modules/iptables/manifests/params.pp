# modules/iptables/manifests/params.pp
#
# Synopsis:
#       Parameters for the iptables puppet module.


class iptables::params {

    case $::operatingsystem {
        Fedora: {

            if $operatingsystemrelease < 16 {
                $packages = [
                    'iptables',
                    'iptables-ipv6',
                ]
                $services = [
                    'iptables',
                    'ip6tables',
                ]
            } else {
                $packages = [
                    'iptables',
                ]
                $services = [
                    'iptables',
                ]
            }

        }

        default: {
            fail ("The iptables module is not yet supported on ${operatingsystem}.")
        }

    }

}
