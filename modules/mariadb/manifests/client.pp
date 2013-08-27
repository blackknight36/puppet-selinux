# modules/mariadb/manifests/client.pp
#
# Synopsis:
#       Configures a host as a mariadb client.
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


class mariadb::client ($config_uri=undef) {

    include 'mariadb::params'

    package { $mariadb::params::clientpackages:
        ensure  => installed,
        notify  => Service[$mariadb::params::service_name],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$mariadb::params::service_name],
        notify      => Service[$mariadb::params::service_name],
        #subscribe   => Package[$mariadb::params::clientpackages],
    }

    if $config_uri != undef {
        file { '/etc/my.cnf.d/client.cnf':
            source  => $config_uri,
            before  => Package[$mariadb::params::clientpackages],
        }
    }

    iptables::tcp_port {
        'mysqld':   port => '3306';
    }

    service { $mariadb::params::service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
