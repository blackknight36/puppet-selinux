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
#
# Example usage:
#
#       include jetbrains

class jetbrains {

    file { '/opt':
        ensure  => directory,
        group   => 'root',
        mode    => '0755',
        owner   => 'root',
        selrole => 'object_r',
        seltype => 'usr_t',
        seluser => 'system_u',
    }

    file { '/opt/jetbrains':
        ensure  => directory,
        group   => 'root',
        mode    => '0755',
        owner   => 'root',
        require => File['/opt'],
        selrole => 'object_r',
        seltype => 'usr_t',
        seluser => 'system_u',
    }

}
