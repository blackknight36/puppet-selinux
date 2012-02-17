# modules/jetbrains/manifests/classes/idea.pp
#
# Synopsis:
#       Configures a host to run JetBrains IDEA.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       name                            instance name
#       ensure          present         instance is to be present/absent
#
# Requires:
#       NONE
#       Class['REQ_MODULE::REQ_CLASS'] <= Use this notation for other resources
#
#       $MODULE_NAME_var1                       Abstract variable 1
#       $MODULE_NAME_var2                       Abstract variable 2
#       $MODULE_NAME_CONFIG_NAME_source         Source URI for the CONFIG_NAME file
#
# Example usage:
#
#       $MODULE_NAME_var1 = 'X_foo'
#       $MODULE_NAME_var2 = 'X_bar'
#       $MODULE_NAME_CONFIG_NAME_source = 'puppet:///private-host/CONFIG_NAME'
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
    jetbrains::idea-release { 'ideaIU-11.0.2':
        build   => '111.277',
    }

    # EAP releases are simpler as their name reflects the build.
    jetbrains::idea-release { 'ideaIU-114.98':
        build   => "114.98",
    }

}