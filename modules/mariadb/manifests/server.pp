# modules/mariadb/manifests/server.pp
#
# Synopsis:
#       Configures a host as a mariadb server.
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


class mariadb::server ($config_uri=undef) {

    include 'mariadb::params'

    package { $mariadb::params::serverpackages:
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
        #subscribe   => Package[$mariadb::params::serverpackages],
    }

    if $config_uri != undef {
        file { '/etc/my.cnf.d/':
            ensure  => 'directory',
            before  => File['/etc/my.cnf.d/server.cnf'],
        }
        file { '/etc/my.cnf.d/server.cnf':
            source  => $config_uri,
            before  => Package[$mariadb::params::serverpackages],
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
