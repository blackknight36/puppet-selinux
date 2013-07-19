# modules/dart/manifests/abstract/ngic_server_node.pp

class dart::abstract::ngic_server_node inherits dart::abstract::server_node {

    include lokkit

    class { 'puppet::client':
    }

    include postgresql::server

    package { [ 'tomcat', 'tomcat-admin-webapps', ]:
        ensure  => installed,
    }

    lokkit::tcp_port { 'tomcat':
        port    => '8080',
    }

}
