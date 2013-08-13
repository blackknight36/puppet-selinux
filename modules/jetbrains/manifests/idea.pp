# modules/jetbrains/manifests/idea.pp
#
# Synopsis:
#       Configures a host to run JetBrains IDEA.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       NONE
#
# Requires:
#       NONE
#
# Example Usage:
#
#       include jetbrains::idea

class jetbrains::idea {

    include jetbrains

    File {
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
    }

    $root = '/opt/jetbrains/idea'
    file { "${jetbrains::idea::root}":
        ensure  => directory,
        mode    => '0755',
        require => File['/opt/jetbrains'],
    }

    $launchers_path = "${jetbrains::idea::root}/launchers"
    file { "${jetbrains::idea::launchers_path}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::idea::root}"],
    }

    $idea_config = "${jetbrains::idea::root}/etc"
    file { "${idea_config}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::idea::root}"],
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
    jetbrains::idea-release { 'ideaIU-12.1.4':
        build   => '129.713',
    }

    jetbrains::idea-release { 'ideaIU-12.0.2':
        build   => '123.123',
    }

    jetbrains::idea-release { 'ideaIU-11.1.4':
        build   => '117.963',
    }

    jetbrains::idea-release { 'ideaIU-11.1.3':
        build   => '117.798',
        ensure  => absent,
    }

    jetbrains::idea-release { 'ideaIU-11.1.2':
        build   => '117.418',
        ensure  => absent,
    }

    # EAP releases are simpler as their name reflects the build.
    jetbrains::idea-release { 'ideaIU-123.150':
        build   => "123.150",
    }

    jetbrains::idea-release { 'ideaIU-114.98':
        build   => "114.98",
        ensure  => absent,
    }

}
