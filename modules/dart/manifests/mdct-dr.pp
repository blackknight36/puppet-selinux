# modules/dart/manifests/mdct-dr.pp

class dart::mdct-dr inherits dart::abstract::dr_server_node {

    class { 'iptables':
        enabled => true,
    }

}
