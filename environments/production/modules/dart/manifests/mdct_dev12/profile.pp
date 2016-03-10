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
        'kio_mtp',
        'man2html',
        'redshift',
    ]:
        ensure  => installed,
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
