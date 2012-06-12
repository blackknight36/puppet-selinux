# modules/dart/manifests/mdct-ngic.pp

class dart::mdct-ngic inherits dart::abstract::ngic_server_node {

    class { 'iptables':
        enabled => true,
    }

}
