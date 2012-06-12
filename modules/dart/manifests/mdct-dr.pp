# modules/dart/manifests/classes/mdct-ngic-dev.pp

class dart::mdct-dr inherits dart::abstract::dr_server_node {

    class { 'iptables':
        enabled => true,
    }

}
