# modules/dart/manifests/mdct-ci-agent1.pp

class dart::mdct-ci-agent1 inherits dart::abstract::est_server_node {

    class { 'iptables':
        enabled => true,
    }

    lokkit::tcp_port { 'teamcity':
        port    => '9090',
    }

}
