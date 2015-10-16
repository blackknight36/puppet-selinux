# modules/dart/manifests/mdct_dr_dev.pp
#
# Synopsis:
#       Design Review application (test and development environment)
#
# Contact:
#       Ben Minshall

class dart::mdct_dr_dev inherits dart::abstract::dr_server_node {

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }

}
