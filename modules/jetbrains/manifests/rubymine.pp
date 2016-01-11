# modules/jetbrains/manifests/rubymine.pp
#
# == Class: jetbrains::rubymine
#
# Configures a host to run JetBrains RubyMine
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class jetbrains::rubymine {

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

    file { $jetbrains::params::rubymine_root:
        ensure  => directory,
        mode    => '0755',
        require => File['/opt/jetbrains'],
    }

    $launchers_path = "${jetbrains::params::rubymine_root}/launchers"
    file { $jetbrains::rubymine::launchers_path:
        ensure  => directory,
        mode    => '0755',
        require => File[$jetbrains::params::rubymine_root],
    }

    $rubymine_config = "${jetbrains::params::rubymine_root}/etc"
    file { $rubymine_config:
        ensure  => directory,
        mode    => '0755',
        require => File[$jetbrains::params::rubymine_root],
    }

    $rubymine_icon = "${rubymine_config}/rubymine.png"
    file { $rubymine_icon:
        source  => 'puppet:///modules/jetbrains/rubymine/rubymine.png',
        require => File[$rubymine_config],
    }

    $rubymine_vmoptions = "${rubymine_config}/vmoptions"
    file { $rubymine_vmoptions:
        source  => 'puppet:///modules/jetbrains/rubymine/vmoptions',
        require => File[$rubymine_config],
    }

    $rubymine_rc = "${rubymine_config}/rc"
    file { $rubymine_rc:
        content => template('jetbrains/rubymine/rc'),
        require => File[$rubymine_config],
    }

}
