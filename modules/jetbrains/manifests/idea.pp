# modules/jetbrains/manifests/classes/idea.pp
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
# Example usage:
#
#       include jetbrains::idea

class jetbrains::idea {

    include jetbrains

    $idea_root = '/opt/jetbrains/idea'
    file { "${idea_root}":
        ensure  => directory,
        group   => 'root',
        mode    => '0755',
        owner   => 'root',
        require => File['/opt/jetbrains'],
        selrole => 'object_r',
        seltype => 'usr_t',
        seluser => 'system_u',
    }

    $idea_launchers = "${idea_root}/launchers"
    file { "${idea_launchers}":
        ensure  => directory,
        group   => 'root',
        mode    => '0755',
        owner   => 'root',
        require => File["${idea_root}"],
        selrole => 'object_r',
        seltype => 'usr_t',
        seluser => 'system_u',
    }

    $idea_config = "${idea_root}/etc"
    file { "${idea_config}":
        ensure  => directory,
        group   => 'root',
        mode    => '0755',
        owner   => 'root',
        require => File["${idea_root}"],
        selrole => 'object_r',
        seltype => 'etc_t',
        seluser => 'system_u',
    }

    $idea_vmoptions = "${idea_config}/vmoptions"
    file { "${idea_vmoptions}":
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        require => File["${idea_config}"],
        selrole => 'object_r',
        seltype => 'etc_t',
        seluser => 'system_u',
        source  => 'puppet:///modules/jetbrains/idea/vmoptions',
    }

    $idea_rc = "${idea_config}/rc"
    file { "${idea_rc}":
        content => template('jetbrains/idea/rc'),
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        require => File["${idea_config}"],
        selrole => 'object_r',
        seltype => 'etc_t',
        seluser => 'system_u',
    }

    # Stable releases are named with the release, but extract to the
    # build.
    #
    # Present policy plan is to enforce absence of old stable releases
    # to ensure that no more than two stable releases are installed at any
    # given time.
    jetbrains::idea-release { 'ideaIU-11.1.2':
        build   => '117.418',
    }

    jetbrains::idea-release { 'ideaIU-11.1.1':
        build   => '117.117',
    }

    jetbrains::idea-release { 'ideaIU-11.1':
        build   => '117.105',
        ensure  => absent,
    }

    jetbrains::idea-release { 'ideaIU-11.0.2':
        build   => '111.277',
        ensure  => absent,
    }

    # EAP releases are simpler as their name reflects the build.
    jetbrains::idea-release { 'ideaIU-114.98':
        build   => "114.98",
    }

}
