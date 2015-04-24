# modules/sigul/manifests/bridge.pp
#
# == Class: sigul::bridge
#
# Manages a host as a Sigul Bridge to relay requests between clients and the
# Sigul Server.
#
# === Parameters
#
# ==== Required
#
# [*nss_password*]
#   Password used to protect the NSS certificate database.
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


class sigul::bridge (
        $nss_password,
        $enable=true,
        $ensure='running',
    ) inherits ::sigul::params {

    package { $::sigul::params::packages:
        ensure => installed,
        notify => Service[$::sigul::params::bridge_services],
    }

    File {
        owner     => 'root',
        group     => 'sigul',
        mode      => '0640',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        before    => Service[$::sigul::params::bridge_services],
        notify    => Service[$::sigul::params::bridge_services],
        subscribe => Package[$::sigul::params::packages],
    }

    file { '/etc/sigul/bridge.conf':
        content => template('sigul/bridge.conf'),
    }

    iptables::tcp_port {
        'sigul_clients':    port => '44334';
        'sigul_server':     port => '44333';
    }

    service { $::sigul::params::bridge_services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
