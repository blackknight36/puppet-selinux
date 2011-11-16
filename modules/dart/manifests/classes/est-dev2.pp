# modules/dart/manifests/classes/est-dev2.pp

class dart::est-dev2 inherits dart::est_server_node {

    class { 'iptables':
        enabled => true,
    }

}
