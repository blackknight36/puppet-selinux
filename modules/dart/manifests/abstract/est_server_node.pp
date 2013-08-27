# modules/dart/manifests/abstract/est_server_node.pp

class dart::abstract::est_server_node inherits dart::abstract::guarded_server_node {

    include 'autofs'
    include postgresql::server

    class { 'puppet::client':
    }

    package { [ 'tomcat6', 'tomcat6-admin-webapps', ]:
        ensure  => installed,
    }

}
