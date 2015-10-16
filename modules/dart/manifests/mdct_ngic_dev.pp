# modules/dart/manifests/mdct_ngic_dev.pp
#
# Synopsis:
#       NGIC Materials Database (testing and development environment)
#
# Contact:
#       Ben Minshall

class dart::mdct_ngic_dev inherits dart::abstract::ngic_server_node {

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }

}
