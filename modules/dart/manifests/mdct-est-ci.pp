# modules/dart/manifests/mdct-est-ci.pp

class dart::mdct-est-ci inherits dart::abstract::est_server_node {

    class { 'iptables':
        enabled => true,
    }

}
