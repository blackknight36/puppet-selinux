# modules/dart/manifests/classes/est_server_node.pp

class dart::est_server_node inherits dart::server_node {

    include postgresql::server

    package { 'tomcat6':
        ensure  => installed,
    }

}
