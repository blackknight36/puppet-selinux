# modules/dart/manifests/mdct_dev12/profile.pp
#
# == Class: dart::mdct_dev12::profile
#
# Manages a bunch of profile-like resources on John Florian's workstation.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_dev12::profile {

    include 'dart::mdct_dev12::profile::root'

    class { 'plymouth':
        theme   => 'details',
    }

    package { [
        'kcometen4',
        'kde-plasma-yawp',
        'kdeartwork-screensavers',
        'kio_mtp',
        'man2html',
        'qstars-kde',
        'redshift',
        'rss-glx-kde',
        'tempest-kde',
    ]:
        ensure  => installed,
    }

    # Ditch the KDE screenlocker in favor of xscreensaver.
    file { '/usr/libexec/kde4/kscreenlocker_greet':
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
        source => 'puppet:///private-host/kscreenlocker_greet',
    }

    cron::job { 'git-summary':
        command => 'nice ionice -c 3 git-summary',
        dow     => 'Mon-Fri',
        hour    => '7',
        minute  => '33',
        user    => 'd13677',
        mailto  => 'john.florian@dart.biz',
    }

}
