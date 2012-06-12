# modules/dart/manifests/classes/mdct-ci-agent1.pp

class dart::mdct-ci-agent1 inherits dart::abstract::est_server_node {

    class { 'iptables':
        enabled => true,
    }

    include 'lokkit'
    lokkit::tcp_port { 'teamcity':
        port    => '9090',
    }

}
