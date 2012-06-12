# modules/dart/manifests/classes/mdct-est-dev2.pp

class dart::mdct-est-dev2 inherits dart::abstract::est_server_node {

    class { 'iptables':
        enabled => true,
    }

}
