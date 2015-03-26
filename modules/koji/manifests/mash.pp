# modules/koji/manifests/mash.pp
#
# == Class: koji::mash
#
# Manages the Koji mash client on a host.
#
# === Parameters
#
# ==== Required
#
# [*hub*]
#   URL of your Koji-Hub service.
#
# [*top_dir*]
#   Directory containing the "repos/" directory.
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class koji::mash (
        $hub,
        $top_dir,
    ) inherits ::koji::params {

    package { $::koji::params::mash_packages:
        ensure  => installed,
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::koji::params::mash_packages],
    }

    file { '/etc/mash/mash.conf':
        content => template('koji/mash/mash.conf'),
    }

    file { $::koji::params::our_mashes:
        ensure => directory,
        mode   => '0755',
    }

}
