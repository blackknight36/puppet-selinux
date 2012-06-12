# modules/dart/manifests/classes/mdct-ngic-dev.pp

class dart::mdct-ngic inherits dart::abstract::ngic_server_node {

    class { 'iptables':
        enabled => true,
    }

}
