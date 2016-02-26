# modules/dart/manifests/abstract/cats_server_node.pp

class dart::abstract::cats_server_node inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'

    yumrepo { 'nexus-release':
        name            => 'nexus-release',
        baseurl         => 'http://mdct-nexus:8080/content/repositories/releases',
        gpgcheck        => false,
        enabled         => true,
        metadata_expire => 60,
    }

    package { [ 'tomcat', 'tomcat-admin-webapps', ]:
        ensure  => installed,
    }


    file { '/etc/tomcat/tomcat-users.xml':
        owner     => 'tomcat',
        group     => 'tomcat',
        mode      => '0660',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package['tomcat'],
        source    => 'puppet:///modules/dart/tomcat/tomcat-users.xml',
    }

    package { [ 'postgresql.x86_64', 'postgresql-contrib.x86_64', 'postgresql-jdbc.noarch', 'postgresql-libs.x86_64', 'postgresql-server.x86_64', 'tomcat-native.x86_64',
                'crypto-utils', ]:
        ensure    => installed,
    }

    file { '/usr/share/tomcat/lib/postgresql-jdbc.jar':
        ensure => link,
        target => '/usr/share/java/postgresql-jdbc.jar',
    }

    iptables::tcp_port {
        'http_external': port => '80';
    }

    iptables::tcp_port {
        'https_external': port => '443';
    }

    class { 'apache':
        network_connect => true,
    }

    include 'apache::mod_ssl'

    apache::site_config {
        'ssl':
            source    => 'puppet:///modules/dart/httpd/cats-ssl.conf',
            subscribe => Class['apache::mod_ssl'];
    }

    file { '/etc/tomcat/server.xml':
        owner     => 'tomcat',
        group     => 'tomcat',
        mode      => '0664',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package['tomcat'],
        source    => 'puppet:///modules/dart/tomcat/cats-server.xml',
    }

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }

    class { 'postgresql::server':
        pg_hba_conf_defaults => false,
        listen_addresses     => '*',
    }

    postgresql::server::role{'postgres':
        password_hash => postgresql_password('postgres', 'postgres'),
        createdb      => true,
        createrole    => true,
        replication   => true,
        superuser     => true,
    }


    postgresql::server::role{'cats':
        password_hash    => postgresql_password('cats', 'cats'),
    }

    postgresql::server::role{'cats_reader':
        password_hash => postgresql_password('cats_reader', 'reader'),
    }


    postgresql::server::db{'cats':
        user     => 'postgres',
        password => '',
        owner    => 'cats',
        require  => Postgresql::Server::Role['cats'],
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
