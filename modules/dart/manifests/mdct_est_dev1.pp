# modules/dart/manifests/mdct_est_dev1.pp
#
# Synopsis:
#       EST testing and development environment
#
# Contact:
#       Ben Minshall

class dart::mdct_est_dev1 inherits dart::abstract::est_server_node {

    iptables::tcp_port {
        'http': port => '80';
    }

}
