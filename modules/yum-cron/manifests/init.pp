# modules/yum-cron/manifests/init.pp

class yum-cron {

    package { "yum-cron":
        ensure  => installed,
    }

    # While yum-updatesd has some nice features, it's a bloated memory pig.
    package { "yum-updatesd":
        ensure  => absent,
    }

    file { "/etc/sysconfig/yum-cron":
        group   => "root",
        mode    => 644,
        owner   => "root",
        require => Package["yum-cron"],
        source  => [
            "puppet:///private-host/yum-cron/yum-cron",
            "puppet:///modules/yum-cron/yum-cron",
        ],
    }

    if $operatingsystemrelease == 16 {
        # Fedora 16 is using systemd which expects the PID file to indicate if
        # the daemon is running or not.  Yum-cron is a pseudo-daemon.  The
        # service's init file merely creates a lock file if it's to be
        # enabled.  Crond then execs the yum-cron script, which silently fails
        # if the lock file doesn't exist.  This PID file only exists while the
        # cron job is actually runnning and is therefore a poor indicator to
        # systemd of the daemon's configuration.
        service { "yum-cron":
            ensure      => running,
            hasrestart  => true,
            hasstatus   => false,
            provider    => 'init',
            require     => [
                Package["yum-cron"],
                Package["yum-updatesd"],
            ],
            status      => 'test -e /var/lock/subsys/yum-cron',
            subscribe   => [
                File["/etc/sysconfig/yum-cron"],
            ]
        }
    } else {
        service { "yum-cron":
            enable      => true,
            ensure      => running,
            hasrestart  => true,
            hasstatus   => true,
            require     => [
                Package["yum-cron"],
                Package["yum-updatesd"],
            ],
            subscribe   => [
                File["/etc/sysconfig/yum-cron"],
            ]
        }
    }

}
