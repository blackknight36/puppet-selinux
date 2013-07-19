# modules/dart/manifests/abstract/est_server_node.pp

class dart::abstract::est_server_node inherits dart::abstract::server_node {

    include postgresql::server

    class { 'puppet::client':
    }

    package { [ 'tomcat6', 'tomcat6-admin-webapps', ]:
        ensure  => installed,
    }

}
