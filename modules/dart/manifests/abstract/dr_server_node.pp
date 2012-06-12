# modules/dart/manifests/abstract/dr_server_node.pp

class dart::abstract::dr_server_node inherits dart::abstract::server_node {

    include lokkit
    include postgresql::server

    package { [ 'tomcat', 'tomcat-admin-webapps', ]:
        ensure  => installed,
    }

    lokkit::tcp_port { 'tomcat':
        port    => '8080',
    }

}
