# modules/dart/manifests/mdct_dev21.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Caspian Peavyhouse

class dart::mdct_dev21 inherits dart::abstract::workstation_node {

    include 'dart::abstract::pycharm::community'
    include 'dart::subsys::yum_cron'
    include 'jetbrains::idea'

    iptables::tcp_port {
        'tomcat': port => '8080';
    }

}
