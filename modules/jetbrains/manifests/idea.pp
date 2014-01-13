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

    file { "${jetbrains::params::idea_root}":
        ensure  => directory,
        mode    => '0755',
        require => File['/opt/jetbrains'],
    }

    $launchers_path = "${jetbrains::params::idea_root}/launchers"
    file { "${jetbrains::idea::launchers_path}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::params::idea_root}"],
    }

    $idea_config = "${jetbrains::params::idea_root}/etc"
    file { "${idea_config}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::params::idea_root}"],
    }

    $idea_vmoptions = "${idea_config}/vmoptions"
    file { "${idea_vmoptions}":
        source  => 'puppet:///modules/jetbrains/idea/vmoptions',
        require => File["${idea_config}"],
    }

    $idea_rc = "${idea_config}/rc"
    file { "${idea_rc}":
        content => template('jetbrains/idea/rc'),
        require => File["${idea_config}"],
    }

    # Stable releases are named with the release, but extract to the
    # build.
    #
    # Present policy plan is to enforce absence of old stable releases
    # to ensure that no more than two stable releases are installed at any
    # given time.
    jetbrains::idea_release { 'ideaIU-13.0.1':
        build   => '133.331',
    }

    jetbrains::idea_release { 'ideaIU-12.1.4':
        build   => '129.713',
    }

    jetbrains::idea_release { 'ideaIU-12.0.2':
        build   => '123.123',
        ensure  => absent,
    }

    jetbrains::idea_release { 'ideaIU-11.1.4':
        build   => '117.963',
        ensure  => absent,
    }

    # EAP releases are simpler as their name reflects the build.
    jetbrains::idea_release { 'ideaIU-129.961':
        build   => "129.961",
    }

    jetbrains::idea_release { 'ideaIU-123.150':
        build   => "123.150",
        ensure  => absent,
    }

    jetbrains::idea_release { 'ideaIU-114.98':
        build   => "114.98",
        ensure  => absent,
    }

}
