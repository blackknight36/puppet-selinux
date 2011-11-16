# modules/dart/manifests/classes/est-dev1.pp

class dart::est-dev1 inherits dart::est_server_node {

    class { 'iptables':
        enabled => true,
    }

}
