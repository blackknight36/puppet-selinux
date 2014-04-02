# modules/mock/manifests/common.pp
#
# == Class: mock::common
#
# Configures a host for basic mock use of mock.
#
# This class is common to and required by all build targets.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class mock::common {

    include 'mock::params'

    package { $mock::params::packages:
        ensure  => installed,
    }

    File {
        owner       => 'root',
        group       => 'mock',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$mock::params::packages],
    }

    file { '/etc/mock/site-defaults.cfg':
        source  => 'puppet:///modules/mock/site-defaults.cfg',
    }

}
