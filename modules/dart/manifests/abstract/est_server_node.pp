# modules/dart/manifests/abstract/est_server_node.pp

class dart::abstract::est_server_node inherits dart::abstract::tomcat_web_app {

    package { [ 'postgresql.x86_64', 'postgresql-contrib.x86_64', 'postgresql-jdbc.noarch', 'postgresql-libs.x86_64', 'postgresql-server.x86_64', ]:
        ensure  => installed,
    }

#    iptables::rules_file { 'est-nat':
#        source  => 'puppet:///private-domain/iptables/est-nat',
#        table   => 'nat',
#    }

     systemd::unit{ 'umask.conf':
        source  => 'puppet:///modules/dart/est_servers/umask.conf',
        extends => 'tomcat.service',
     }

    iptables::tcp_port {
        'http_external': port => '80';
    }
    
    iptables::tcp_port {
        'https_external': port => '443';
    }

    iptables::tcp_port {
        'https_tomcat': port => '8443';
    }


    group { 'estindexers':
        ensure => present,
    }

    user { 'est':
        require => Group['estindexers'],
        groups  => ['estindexers'],
    }

    user { 'tomcat':
        require => [ Group['estindexers'], Package['tomcat'], ],
        groups  => ['estindexers'],
    }

    class { 'postgresql::server':
        pg_hba_conf_defaults => false,
        listen_addresses => '*',
    }

    postgresql::server::role{'postgres':
        password_hash => postgresql_password('postgres', 'postgres'),
        createdb      => true,
        createrole    => true,
        replication   => true,
        superuser     => true,
    }


    postgresql::server::role{'est':
        password_hash    => postgresql_password('est', 'est'),
    }

    postgresql::server::role{'est_reader':
        password_hash => postgresql_password('est_reader', 'reader'),
    }


    postgresql::server::db{'est':
        user     => 'postgres',
        password => '',
        owner    => 'est',
        require  => Postgresql::Server::Role['est'],
    }

    postgresql::server::pg_hba_rule{'allow application network access':
        description => '"local" is for Unix domain socket connections only',
        type        => 'local',
        database    => 'all',
        user        => 'all',
        auth_method => 'trust',
    }

    postgresql::server::pg_hba_rule{'IPv4 connections':
        description => 'IPv4 connections',
        type        => 'host',
        database    => 'all',
        user        => 'all',
        address     => '0.0.0.0/0',
        auth_method => 'md5',
    }

    postgresql::server::pg_hba_rule{'IPv4 local connections':
        description => 'IPv4 local connections',
        type        => 'host',
        database    => 'all',
        user        => 'all',
        address     => '127.0.0.1/32',
        auth_method => 'trust',
    }

    postgresql::server::pg_hba_rule{'IPv6 local connections':
        description => 'IPv6 local connections',
        type        => 'host',
        database    => 'all',
        user        => 'all',
        address     => '::1/128',
        auth_method => 'md5',
    }
}
