# modules/dart/manifests/mdct-00dtl.pp

class dart::mdct-00dtl inherits dart::abstract::server_node {

    class { 'iptables':
        enabled => true,
    }

}
