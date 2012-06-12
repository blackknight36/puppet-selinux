# modules/dart/manifests/classes/mdct-est-ci.pp

class dart::mdct-est-ci inherits dart::abstract::est_server_node {

    class { 'iptables':
        enabled => true,
    }

}
