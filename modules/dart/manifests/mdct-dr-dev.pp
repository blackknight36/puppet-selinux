# modules/dart/manifests/mdct-dr-dev.pp
#
# Synopsis:
#       Design Review application (test and development environment)
#
# Contact:
#       Ben Minshall

class dart::mdct-dr-dev inherits dart::abstract::dr_server_node {

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }

}
