# modules/dart/manifests/abstract/tomcat_web_app.pp
#  Not really used for generic tomcat web apps - should be refactored / renamed

class dart::abstract::tomcat_web_app inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'

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
        source  =>  'puppet:///modules/dart/sudo/tomcat-service',
    }

    file { '/etc/tomcat/tomcat-users.xml':
        owner     => 'tomcat',
        group     => 'tomcat',
        mode      => '0660',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package['tomcat'],
        source    => "puppet:///modules/files/private/${fqdn}/tomcat/tomcat-users.xml",
    }

    file { '/etc/tomcat/context.xml':
        owner     => 'tomcat',
        group     => 'tomcat',
        mode      => '0664',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package['tomcat'],
        source    => "puppet:///modules/files/private/${fqdn}/tomcat/context.xml",
    }

}
