# modules/unwanted-services/manifests/init.pp

class unwanted-services {

    service { "firstboot":
        enable          => false,
        ensure          => stopped,
        hasrestart      => true,
        hasstatus       => true,
    }

    service { "iscsi":
        enable          => false,
        ensure          => stopped,
        hasrestart      => true,
        hasstatus       => true,
    }

    service { "iscsid":
        enable          => false,
        ensure          => stopped,
        hasrestart      => true,
        hasstatus       => true,
    }

    service { "livesys":
        enable          => false,
        #ensure         => stopped,     # there is nothing to stop
        hasrestart      => true,
        hasstatus       => true,
    }

    service { "livesys-late":
        enable          => false,
        #ensure         => stopped,     # there is nothing to stop
        hasrestart      => true,
        hasstatus       => true,
    }

    service { "ModemManager":
        enable          => false,
        ensure          => stopped,
        hasrestart      => true,
        hasstatus       => true,
    }

    # Puppet will endlessly change enable from true to false.  The systemd
    # unit file has evolved since F16 and I don't have time to debug this
    # right now.  Ignoring the service on F17 for now as this generates
    # endless noise from puppet tagmail reports.
    if  $operatingsystem == 'Fedora' and
        $operatingsystemrelease != 'Rawhide' and
        $operatingsystemrelease < 17
    {
        service { "pcscd":
            enable          => false,
            ensure          => stopped,
            hasrestart      => true,
            hasstatus       => true,
        }
    }

}
