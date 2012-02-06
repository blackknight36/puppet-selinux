# modules/dart/manifngics/classes/abstract/ngic_server_node.pp

class dart::ngic_server_node inherits dart::server_node {

    include postgresql::server

    package { [ 'tomcat', 'tomcat-admin-webapps', ]:
        ensure  => installed,
    }

}
