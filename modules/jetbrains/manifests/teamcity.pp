# modules/jetbrains/manifests/teamcity.pp
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
#       - Generally you will want to just use jetbrains::teamcity_release
#       instead.


class jetbrains::teamcity {

    include 'jetbrains'
    include 'jetbrains::params'

    $buildserver_root = "${jetbrains::params::teamcity_root}/.BuildServer"

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

    $teamcity_config = "${jetbrains::params::teamcity_root}/etc"
    file { "${teamcity_config}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::params::teamcity_root}"],
    }

    $teamcity_rc = "${teamcity_config}/rc"
    file { "${teamcity_rc}":
        content => template('jetbrains/teamcity/rc'),
        require => File["${teamcity_config}"],
    }

    file { "${buildserver_root}":
        ensure  => directory,
        mode    => '0755',
        require => File["${jetbrains::params::teamcity_root}"],
    }

}
