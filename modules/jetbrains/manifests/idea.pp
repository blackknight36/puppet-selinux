# modules/jetbrains/manifests/idea.pp
#
# == Class: jetbrains::idea
#
# Configures a host to run JetBrains IDEA.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class jetbrains::idea {

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

    file { $jetbrains::params::idea_root:
        ensure  => directory,
        mode    => '0755',
        require => File['/opt/jetbrains'],
    }

    $launchers_path = "${jetbrains::params::idea_root}/launchers"
    file { $jetbrains::idea::launchers_path:
        ensure  => directory,
        mode    => '0755',
        require => File[$jetbrains::params::idea_root],
    }

    $idea_config = "${jetbrains::params::idea_root}/etc"
    file { $idea_config:
        ensure  => directory,
        mode    => '0755',
        require => File[$jetbrains::params::idea_root],
    }

    $idea_vmoptions = "${idea_config}/vmoptions"
    file { $idea_vmoptions:
        source  => 'puppet:///modules/jetbrains/idea/vmoptions',
        require => File[$idea_config],
    }

    $idea_rc = "${idea_config}/rc"
    file { $idea_rc:
        content => template('jetbrains/idea/rc'),
        require => File[$idea_config],
    }

}
