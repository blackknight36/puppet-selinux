# modules/jetbrains/manifests/teamcity/server.pp
#
# Synopsis:
#       Configures a host to run a JetBrains TeamCity Server.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       NONE
#
# Requires:
#       NONE
#
# Notes:
#       - Generally, you will want to just include the class
#       'jetbrains::teamcity::server_release' instead.


class jetbrains::teamcity::server {

    include 'jetbrains'
    include 'jetbrains::params'

    File {
        owner   => 'teamcity',
        group   => 'teamcity',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        require => User['teamcity'],
    }

    file { "${jetbrains::params::teamcity_root}":
        ensure  => directory,
        mode    => '0755',
        require => File['/opt/jetbrains'],
    }

    file { "${jetbrains::params::teamcity_etc_root}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::params::teamcity_root}"],
    }

    file { "${jetbrains::params::teamcity_rc}":
        content => template('jetbrains/teamcity/rc'),
        require => File["${jetbrains::params::teamcity_etc_root}"],
    }

    file { "${jetbrains::params::teamcity_buildserver_root}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::params::teamcity_root}"],
    }

}
