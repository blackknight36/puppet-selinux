# modules/flock_herder/manifests/init.pp
#
# == Class: flock_herder
#
# Manages flock-herder on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*conf_source*]
#   Source URI from where the herd.conf is to be obtained.  The default is one
#   provided by the flock_herder puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class flock_herder (
        $conf_source='puppet:///modules/flock_herder/herd.conf',
    ) inherits ::flock_herder::params {

    package { $::flock_herder::params::packages:
        ensure => latest,
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::flock_herder::params::packages],
    }

    file { '/etc/herd.conf':
        source  => $conf_source,
    }

}
