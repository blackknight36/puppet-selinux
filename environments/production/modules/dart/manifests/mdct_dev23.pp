# modules/dart/manifests/mdct_dev23.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Leo Moore


class dart::mdct_dev23 inherits dart::abstract::workstation_node {

    include 'dart::abstract::pycharm::community'
    include 'dart::subsys::yum_cron'
    include 'dart::abstract::idea'

    iptables::tcp_port {
        'tomcat': port => '8080';
    }

}
