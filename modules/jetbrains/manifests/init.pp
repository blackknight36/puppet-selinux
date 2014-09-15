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

    file { $jetbrains::params::root:
        require => File['/opt'],
    }

    $jetbrains_config = "${jetbrains::params::root}/etc"
    file { $jetbrains_config:
        ensure  => directory,
        require => File[$jetbrains::params::root],
    }

    $jetbrains_icon = "${jetbrains_config}/jetbrains.png"
    file { $jetbrains_icon:
        source  => 'puppet:///modules/jetbrains/jetbrains.png',
        require => File[$jetbrains_config],
    }

    $jetbrains_menu = "${jetbrains_config}/jetbrains-jetbrains.directory"
    file { $jetbrains_menu:
        source  => 'puppet:///modules/jetbrains/jetbrains-jetbrains.directory',
        require => File[$jetbrains_config],
    }

}
