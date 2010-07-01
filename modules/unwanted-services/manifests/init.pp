# /etc/puppet/modules/unwanted-services/manifests/init.pp

class unwanted-services {

    service { "avahi-daemon":
        enable          => false,
        ensure          => stopped,
        hasrestart      => true,
        hasstatus       => true,
    }

    service { "bluetooth":
        enable          => false,
        ensure          => stopped,
        hasrestart      => true,
        hasstatus       => true,
    }

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

    service { "pcscd":
        enable          => false,
        ensure          => stopped,
        hasrestart      => true,
        hasstatus       => true,
    }

}
