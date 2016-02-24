# modules/dart/manifests/abstract/tcir_server_node.pp

class dart::abstract::tcir_server_node inherits dart::abstract::tomcat_web_app {

    package { [ 'postgresql.x86_64', 'postgresql-contrib.x86_64', 'postgresql-jdbc.noarch', 'postgresql-libs.x86_64', 'postgresql-server.x86_64', 'tomcat-native.x86_64', ]:
        ensure  => installed,
    }

    file { '/usr/share/tomcat/lib/postgresql-jdbc.jar':
        ensure => link,
        target => '/usr/share/java/postgresql-jdbc.jar',
    }

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


    class { 'apache':
        network_connect => true,
    }

    include 'apache::mod_ssl'

    apache::site_config {
        '99-proxy-ajp':
            content   => "
#<IfModule proxy_ajp_module>
#    <IfModule headers_module>
#        RequestHeader unset Expect early
#    </IfModule>
#    <LocationMatch ^/>
#        ProxyPassMatch ajp://127.0.0.1:8009 timeout=3600 retry=5
#        <IfModule deflate_module>
#            AddOutputFilterByType DEFLATE text/javascript text/css text/html text/xml text/json application/xml application/json application/x-yaml
#        </IfModule>
#    </LocationMatch>
#</IfModule>
";
        'ssl':
            source    => 'puppet:///modules/dart/httpd/tcir-ssl.conf',
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
        source    => 'puppet:///modules/dart/tomcat/tcir-server.xml',
    }

    group { 'tcirindexers':
        ensure => present,
    }

    user { 'tcir':
        require => Group['tcirindexers'],
        groups  => ['tcirindexers'],
    }

    user { 'tomcat':
        require => [ Group['tcirindexers'], Package['tomcat'], ],
        groups  => ['tcirindexers'],
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


    postgresql::server::role{'tcir':
        password_hash    => postgresql_password('tcir', 'tcir'),
    }

    postgresql::server::role{'tcir_reader':
        password_hash => postgresql_password('tcir_reader', 'reader'),
    }


    postgresql::server::db{'tcir':
        user     => 'postgres',
        password => '',
        owner    => 'tcir',
        require  => Postgresql::Server::Role['tcir'],
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
