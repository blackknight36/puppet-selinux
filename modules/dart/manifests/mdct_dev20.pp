# modules/dart/manifests/mdct_dev20.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Patti Barba

class dart::mdct_dev20 inherits dart::abstract::workstation_node {

    include 'dart::subsys::yum_cron'
    include 'jetbrains::idea'

    iptables::tcp_port {
        'tomcat': port => '8080';
    }

}
