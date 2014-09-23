# modules/dart/manifests/abstract/tomcat_web_app.pp

class dart::abstract::tomcat_web_app inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'

    class { 'postgresql::server':
        hba_conf    => 'puppet:///private-host/postgresql/pg_hba.conf',
    }

    # puppet::client is included this way to prevent duplicate declaration
    # arising out of dart::abstract::teamcity_server_node.  This works only
    # because the default class params are acceptable here.
    include 'puppet::client'

    package { [ 'tomcat6', 'tomcat6-admin-webapps', ]:
        ensure  => installed,
    }

    iptables::tcp_port {
        'tomcat_web_app': port => '8080';
    }
    iptables::tcp_port {
        'postgres_external': port => '5432';
    }
    iptables::tcp_port {
        'remote_debug': port => '5005';
    }

    sudo::drop_in { 'tomcat-service':
        source  =>  'puppet:///private-domain/sudo/tomcat-service',
    }

    file { '/etc/tomcat/context.xml':
        owner       => 'tomcat',
        group       => 'tomcat',
        mode        => '0664',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package['tomcat6'],
        source      => 'puppet:///private-host/tomcat/context.xml',
    }

}
