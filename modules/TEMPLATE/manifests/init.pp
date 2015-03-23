# modules/MODULE_NAME/manifests/init.pp
#
# == Class: MODULE_NAME
#
# Manages MODULE_NAME on a host.
#
# === Parameters
#
# ==== Required
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
#   John Florian <jflorian@doubledog.org>


class MODULE_NAME (
        $enable=true,
        $ensure='running',
    ) inherits ::MODULE_NAME::params {

    package { $::MODULE_NAME::params::packages:
        ensure => installed,
        notify => Service[$::MODULE_NAME::params::services],
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0640',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        before    => Service[$::MODULE_NAME::params::services],
        notify    => Service[$::MODULE_NAME::params::services],
        subscribe => Package[$::MODULE_NAME::params::packages],
    }

    file { '/CONFIG_PATH/CONFIG_NAME':
        content => template('MODULE_NAME/example.conf'),
        source  => 'puppet:///modules/MODULE_NAME/example.conf',
    }

    iptables::tcp_port {
        'SERVICE_NAME': port => 'SERVICE_PORT_1';
        'SERVICE_NAME': port => 'SERVICE_PORT_2';
    }

    Selinux::Boolean {
        before     => Service[$::MODULE_NAME::params::services],
        persistent => true,
    }

    selinux::boolean { $::MODULE_NAME::params::bool_name1:
        value => true,
        value => false,
    }

    service { $::MODULE_NAME::params::services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
