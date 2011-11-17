# modules/dart/manifests/classes/mdct-est-dev1.pp

class dart::mdct-est-dev1 inherits dart::est_server_node {

    class { 'iptables':
        enabled => true,
    }

}
