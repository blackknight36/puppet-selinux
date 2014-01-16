# modules/dart/manifests/mdct_dev17.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Collin Baker

class dart::mdct_dev17 inherits dart::abstract::workstation_node {

    include 'dart::subsys::yum_cron'
    include 'jetbrains::idea'

    iptables::tcp_port {
        'tomcat': port => '8080';
    }

}
