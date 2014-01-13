# modules/jetbrains/manifests/init.pp
#
# == Class: jetbrains
#
# Configures a host to run JetBrains software.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class jetbrains {

    include 'jetbrains::params'

    File {
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'usr_t',
    }

    file { '/opt':
    }

    file { "${jetbrains::params::root}":
        require => File['/opt'],
    }

}
