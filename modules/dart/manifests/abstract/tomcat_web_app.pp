# modules/dart/manifests/abstract/tomcat_web_app.pp

class dart::abstract::tomcat_web_app inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'

    # puppet::client is included this way to prevent duplicate declaration
    # arising out of dart::abstract::teamcity_server_node.  This works only
    # because the default class params are acceptable here.
    include 'puppet::client'

    package { [ 'tomcat', 'tomcat-admin-webapps', ]:
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

    file { '/etc/tomcat/tomcat-users.xml':
        owner     => 'tomcat',
        group     => 'tomcat',
        mode      => '0664',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package['tomcat'],
        source    => 'puppet:///private-host/tomcat/tomcat-users.xml',
    }

    file { '/etc/tomcat/context.xml':
        owner     => 'tomcat',
        group     => 'tomcat',
        mode      => '0664',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package['tomcat'],
        source    => 'puppet:///private-host/tomcat/context.xml',
    }

}
