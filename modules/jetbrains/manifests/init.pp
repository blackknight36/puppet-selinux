# modules/jetbrains/manifests/init.pp
#
# Synopsis:
#       Configures a host to run JetBrains software.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       NONE
#
# Requires:
#       NONE


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

    file { '/opt':
    }

    file { "${jetbrains::params::root}":
        require => File['/opt'],
    }

}
