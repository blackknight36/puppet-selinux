# modules/dart/manifests/abstract/ngic_server_node.pp

class dart::abstract::ngic_server_node inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'

    class { 'puppet::client':
    }

    class { 'postgresql::server':
        hba_conf    => 'puppet:///private-host/postgresql/pg_hba.conf',
    }

    package { [ 'tomcat', 'tomcat-admin-webapps', ]:
        ensure  => installed,
    }

    iptables::tcp_port {
        'tomcat':   port => '8080';
    }

}
