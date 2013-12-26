# modules/ntp/manifests/params.pp
#
# == Class: ntp::params
#
# Parameters for the ntp puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class ntp::params {

    case $::operatingsystem {
        Fedora: {

            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease > 15
            {
                $_name = 'chrony'
                $sysconfig = undef
                # chronyd deals well with jitter of VM clocks so utilize the
                # service everywhere including on VMs regardless if the
                # hypervisor offers some native clock synchronization method
                # because chrony is likely to do better.  If nothing else, it
                # will be more consistent across disparate hosts
                $needed = true
            } else {
                $_name = 'ntp'
                $sysconfig = "${_name}d"
                # On the other hand, ntpd does not deal well with jitter of VM
                # clocks so defeat the service in that case.  NB: $is_virtual
                # returns a string, not a boolean!  For future safety, it is
                # also double-quoted so if ever becomes a boolean, it will be
                # cast to a string prior to the comparison.
                $needed = ("$is_virtual" == 'false')
            }

            $package = $_name
            $config = "/etc/${_name}.conf"
            $service = "${_name}d"

        }

        default: {
            fail ("The ntp module is not yet supported on ${::operatingsystem}.")
        }

    }

}
