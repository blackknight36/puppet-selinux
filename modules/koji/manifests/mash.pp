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
# [*repo_dir*]
#   Name of the directory that is to be synchronized with the repository tree
#   composited from each of the mashed repositories.
#
# [*top_dir*]
#   Name of the directory containing the "repos/" directory.
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class koji::mash (
        $hub,
        $repo_dir,
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

    file {
        '/etc/mash/mash.conf':
            content => template('koji/mash/mash.conf');

        $::koji::params::mash_dir:
            ensure => directory,
            mode   => '0755';

        $::koji::params::mash_everything_bin:
            mode    => '0755',
            content => template('koji/mash/mash-everything');
    }

    concat { $::koji::params::mash_everything_conf:
        ensure => 'present',
    }

    concat::fragment { 'header':
        target  => $::koji::params::mash_everything_conf,
        content => template('koji/mash/mash-everything.conf'),
        order   => '01',
    }

}
