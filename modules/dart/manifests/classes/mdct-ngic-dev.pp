# modules/dart/manifests/classes/mdct-ngic-dev.pp

class dart::mdct-ngic-dev inherits dart::ngic_server_node {

    class { 'iptables':
        enabled => true,
    }

}
