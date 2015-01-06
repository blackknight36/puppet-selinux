# modules/dart/manifests/mdct_dev22.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Garrett Schafsnitz


class dart::mdct_dev22 inherits dart::abstract::workstation_node {

    include 'dart::abstract::pycharm::community'
    include 'dart::subsys::yum_cron'
    include 'dart::abstract::idea'

    iptables::tcp_port {
        'tomcat': port => '8080';
    }

}
