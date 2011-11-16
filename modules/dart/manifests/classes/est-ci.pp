# modules/dart/manifests/classes/est-ci.pp

class dart::est-ci inherits dart::est_server_node {

    class { 'iptables':
        enabled => true,
    }

}
