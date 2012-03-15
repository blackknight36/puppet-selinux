# modules/dart/manifests/classes/mdct-00dtl.pp

class dart::mdct-00dtl inherits dart::est_server_node {

    class { 'iptables':
        enabled => true,
    }

}
