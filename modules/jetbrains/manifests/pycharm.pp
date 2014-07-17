# modules/jetbrains/manifests/pycharm.pp
#
# == Class: jetbrains::pycharm
#
# Configures a host to run JetBrains PyCharm.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class jetbrains::pycharm {

    include 'jetbrains'
    include 'jetbrains::params'

    File {
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
    }

    file { "${jetbrains::params::pycharm_root}":
        ensure  => directory,
        mode    => '0755',
        require => File['/opt/jetbrains'],
    }

    $launchers_path = "${jetbrains::params::pycharm_root}/launchers"
    file { "${jetbrains::pycharm::launchers_path}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::params::pycharm_root}"],
    }

    $pycharm_config = "${jetbrains::params::pycharm_root}/etc"
    file { "${pycharm_config}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::params::pycharm_root}"],
    }

    $pycharm_icon = "${pycharm_config}/pycharm.png"
    file { "${pycharm_icon}":
        source  => 'puppet:///modules/jetbrains/pycharm/pycharm.png',
        require => File["${pycharm_config}"],
    }

    $pycharm_vmoptions = "${pycharm_config}/vmoptions"
    file { "${pycharm_vmoptions}":
        source  => 'puppet:///modules/jetbrains/pycharm/vmoptions',
        require => File["${pycharm_config}"],
    }

    $pycharm_rc = "${pycharm_config}/rc"
    file { "${pycharm_rc}":
        content => template('jetbrains/pycharm/rc'),
        require => File["${pycharm_config}"],
    }

}
