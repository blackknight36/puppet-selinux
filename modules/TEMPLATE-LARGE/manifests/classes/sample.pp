# modules/MODULE_NAME/manifests/classes/CLASS_NAME.pp
#
# Synopsis:
#       Configures a host as a CLASS_NAME server.
#
# Parameters:
#       NONE
#
# Requires:
#       Class['postgresql::server']     <= Use this notation for other resources
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
#       include MODULE_NAME::CLASS_NAME

class MODULE_NAME::CLASS_NAME {

    include lokkit

    case $MODULE_NAME_CONFIG_NAME_source {
        '': {
            fail('Required $MODULE_NAME_CONFIG_NAME_source variable is not defined')
        }
    }

    package { 'PACKAGE_NAME':
	ensure	=> installed,
    }

    package { 'CONFLICTING_PACKAGE_NAME':
	ensure	=> absent,
	# It may be necessary to have the replacement installed prior to
	# removal of the conflicting package.
        require => Package['PACKAGE_NAME'],
    }

    # static file
    file { '/CONFIG_PATH/CONFIG_NAME':
        # don't forget to verify these!
        group	=> 'root',
        mode    => '0640',
        owner   => 'root',
        require => Package['PACKAGE_NAME'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        source  => [
            'puppet:///private-host/MODULE_NAME/CONFIG_NAME',
            'puppet:///private-domain/MODULE_NAME/CONFIG_NAME',
            'puppet:///modules/MODULE_NAME/CONFIG_NAME',
        ],
    }

    # template file
    file { '/CONFIG_PATH/CONFIG_NAME':
	content	=> template('MODULE_NAME/CONFIG_NAME'),
        # don't forget to verify these!
        group	=> 'root',
        mode    => '0640',
        owner   => 'root',
        require => Package['PACKAGE_NAME'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
    }

    lokkit::tcp_port { 'SERVICE_NAME':
        port    => 'SERVICE_PORT',
    }

    service { 'SERVICE_NAME':
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec['open-SERVICE_NAME-tcp-port'],
            Package['CONFLICTING_PACKAGE_NAME'],
            Package['PACKAGE_NAME'],
        ],
        subscribe	=> [
            File['/CONFIG_PATH/CONFIG_NAME'],
        ],
    }

}
