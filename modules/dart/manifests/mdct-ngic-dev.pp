# modules/dart/manifests/mdct-ngic-dev.pp
#
# Synopsis:
#       NGIC Materials Database (testing and development environment)
#
# Contact:
#       Ben Minshall

class dart::mdct-ngic-dev inherits dart::abstract::ngic_server_node {

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }

}
