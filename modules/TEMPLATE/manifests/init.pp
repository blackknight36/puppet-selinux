# modules/MODULE_NAME/manifests/CLASS_NAME.pp
#
# Synopsis:
#       Configures a host as a MODULE_NAME CLASS_NAME.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
# Notes:
#
#       1. Default is 'present'.


class MODULE_NAME::CLASS_NAME {

    include lokkit

    package { 'PACKAGE_NAME':
        ensure  => installed,
    }

    package { 'CONFLICTING_PACKAGE_NAME':
        ensure  => absent,
        # It may be necessary to have the replacement installed prior to
        # removal of the conflicting package.
        require => Package['PACKAGE_NAME'],
    }

    # static file
    file { '/CONFIG_PATH/CONFIG_NAME':
        # don't forget to verify these!
        group   => 'root',
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
        content => template('MODULE_NAME/CONFIG_NAME'),
        # don't forget to verify these!
        group   => 'root',
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
        enable          => true,
        ensure          => running,
        hasrestart      => true,
        hasstatus       => true,
        require         => [
            Class['REQ_MODULE::REQ_CLASS'],
            Exec['open-SERVICE_NAME-tcp-port'],
            Package['CONFLICTING_PACKAGE_NAME'],
            Package['PACKAGE_NAME'],
        ],
        subscribe       => [
            File['/CONFIG_PATH/CONFIG_NAME'],
        ],
    }

}
