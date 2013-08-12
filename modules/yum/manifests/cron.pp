# modules/yum/manifests/cron.pp
#
# Synopsis:
#       Configures a host to apply yum updates periodically via cron.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       conf_source             URI of yum-cron configuration source.

class yum::cron ($conf_source) {

    include 'yum::params'

    package { $yum::params::packages:
        ensure  => installed,
        notify  => Service[$yum::params::services],
    }

    # While yum-updatesd has some nice features, it's a bloated memory pig.
    package { 'yum-updatesd':
        ensure  => absent,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$yum::params::services],
        notify      => Service[$yum::params::services],
        subscribe   => Package[$yum::params::packages],
    }

    file { $yum::params::cron_conf_target:
        source  => $conf_source,
    }

    if $operatingsystemrelease < 16 {
        service { $yum::params::services:
            enable      => true,
            ensure      => running,
            hasrestart  => true,
            hasstatus   => true,
        }
    } else {
        # Fedora 16 introduces systemd which expects the PID file to indicate
        # if the daemon is running or not.  Yum-cron is a pseudo-daemon.  The
        # service's init file merely creates a lock file if it's to be
        # enabled.  Crond then execs the yum-cron script, which silently fails
        # if the lock file doesn't exist.  This PID file only exists while the
        # cron job is actually runnning and is therefore a poor indicator to
        # systemd of the daemon's configuration.
        service { $yum::params::services:
            enable      => true,
            ensure      => running,
            hasrestart  => true,
            hasstatus   => true,
            status      => 'test -e /var/lock/subsys/yum-cron',
        }
    }

}
