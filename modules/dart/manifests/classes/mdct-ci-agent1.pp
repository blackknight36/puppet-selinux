# modules/dart/manifests/classes/mdct-ci-agent1.pp

class dart::mdct-ci-agent1 inherits dart::est_server_node {

    class { 'iptables':
        enabled => true,
    }

}
