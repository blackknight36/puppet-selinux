# modules/MODULE_NAME/manifests/CLASS_NAME.pp
#
# Synopsis:
#       Configures a host as a MODULE_NAME CLASS_NAME.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
# Notes:
#
#       1. Default is 'present'.


class MODULE_NAME::CLASS_NAME {

    include 'MODULE_NAME::params'

    package { $MODULE_NAME::params::packages:
        ensure  => installed,
        notify  => Service[$MODULE_NAME::params::service_name],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$MODULE_NAME::params::service_name],
        notify      => Service[$MODULE_NAME::params::service_name],
        subscribe   => Package[$MODULE_NAME::params::packages],
    }

    file { '/CONFIG_PATH/CONFIG_NAME':
        content => template('MODULE_NAME/CONFIG_NAME'),
        # ... or ...
        source  => [
            'puppet:///private-host/MODULE_NAME/CONFIG_NAME',
            'puppet:///private-domain/MODULE_NAME/CONFIG_NAME',
            'puppet:///modules/MODULE_NAME/CONFIG_NAME',
        ],
    }

    lokkit::tcp_port {
        'SERVICE_NAME': port => 'SERVICE_PORT_1',
        };
    }

    service { $MODULE_NAME::params::service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
