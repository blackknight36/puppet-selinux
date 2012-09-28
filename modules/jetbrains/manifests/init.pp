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

    file { '/opt/jetbrains':
        require => File['/opt'],
    }

}
