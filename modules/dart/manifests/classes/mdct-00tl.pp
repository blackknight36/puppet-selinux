# modules/dart/manifests/classes/mdct-00tl.pp

class dart::mdct-00tl inherits dart::server_node {

    class { 'iptables':
        enabled => true,
    }

}
