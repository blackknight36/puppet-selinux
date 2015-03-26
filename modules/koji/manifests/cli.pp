# modules/koji/manifests/cli.pp
#
# == Class: koji::cli
#
# Manages the Koji CLI on a host.
#
# === Parameters
#
# ==== Required
#
# [*hub*]
#   URL of your Koji-Hub server.
#
# [*web*]
#   URL of your Koji-Web server.
#
# [*downloads*]
#   URL of your package download site.
#
# [*top_dir*]
#   Directory containing the "repos/" directory.
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class koji::cli (
        $hub,
        $web,
        $downloads,
        $top_dir,
    ) inherits ::koji::params {

    package { $koji::params::cli_packages:
        ensure  => installed,
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$koji::params::cli_packages],
    }

    file { '/etc/koji.conf':
        content => template('koji/cli/koji.conf'),
    }

}
