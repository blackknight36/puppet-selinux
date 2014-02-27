# modules/ovirt/manifests/guest.pp
#
# == Class: ovirt::guest
#
# Configures a host as a ovirt guest.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class ovirt::guest {

    include 'ovirt::params'

    # Only install the packages and run the services if this is a guest VM on
    # an oVirt host.  This uses a custom fact provided by this module.
    if $is_ovirt_guest and $::operatingsystem == 'Fedora' and $::operatingsystemrelease >= 17 {

        package { $ovirt::params::guest_packages:
            ensure  => installed,
            notify  => Service[$ovirt::params::guest_service_name],
        }

        service { $ovirt::params::guest_service_name:
            enable      => true,
            ensure      => running,
            hasrestart  => true,
            hasstatus   => true,
        }

    }

}
