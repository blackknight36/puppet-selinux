# modules/dart/manifests/mdct-00dw.pp

class dart::mdct-00dw inherits dart::abstract::server_node {

    class { 'iptables':
        enabled => true,
    }

}
