# modules/jetbrains/manifests/classes/jetbrains.pp
#
# Synopsis:
#       Configures a host to run JetBrains software.
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
