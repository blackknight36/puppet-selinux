# modules/dart/manifests/unwanted_services.pp
#
# == Class: dart::unwanted_services
#
# Stops and disables several services that are typically of no value.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#   John Florian <john.florian@dart.biz>


class dart::unwanted_services {

    Service {
        enable     => false,
        ensure     => stopped,
        hasrestart => true,
        hasstatus  => true,
    }

    service {
        'firstboot':
        ;

        'livesys':
            ensure => undef,    # there is nothing to stop
        ;

        'livesys-late':
            ensure => undef,    # there is nothing to stop
        ;
    }

    # Puppet will endlessly change enable from true to false.  The systemd
    # unit file has evolved since F16 and I don't have time to debug this
    # right now.  Ignoring the service on F17 for now as this generates
    # endless noise from puppet tagmail reports.
    if  $::operatingsystem == 'Fedora' and
        $::operatingsystemrelease != 'Rawhide' and
        $::operatingsystemrelease < 17
    {
        service { 'pcscd': }
    }

}
