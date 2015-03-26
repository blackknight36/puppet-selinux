# modules/koji/manifests/kojira.pp
#
# == Class: koji::kojira
#
# Manages the Koji Kojira component on a host.
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
# [*enable*]
#   Instance is to be started at boot.  Either true (default) or false.
#
# [*ensure*]
#   Instance is to be 'running' (default) or 'stopped'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class koji::kojira (
        $hub,
        $top_dir,
        $enable=true,
        $ensure='running',
    ) inherits ::koji::params {

    package { $::koji::params::kojira_packages:
        ensure => installed,
        notify => Service[$::koji::params::kojira_services],
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        before    => Service[$::koji::params::kojira_services],
        notify    => Service[$::koji::params::kojira_services],
        subscribe => Package[$::koji::params::kojira_packages],
    }

    file { '/etc/kojira/kojira.conf':
        content => template('koji/kojira/kojira.conf'),
    }

    service { $::koji::params::kojira_services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
