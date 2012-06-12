# modules/dart/manifests/classes/mdct-est-dev1.pp

class dart::mdct-est-dev1 inherits dart::abstract::est_server_node {

    class { 'iptables':
        enabled => true,
    }

    lokkit::tcp_port {
        'http':                 port => '80';
    }

}
