# modules/dart/manifests/mdct-est-dev1.pp
#
# Synopsis:
#       EST testing and development environment
#
# Contact:
#       Ben Minshall

class dart::mdct-est-dev1 inherits dart::abstract::est_server_node {

    class { 'iptables':
        enabled => true,
    }

    lokkit::tcp_port {
        'http':                 port => '80';
    }

}
