# modules/dart/manifests/mdct_dev9.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Nathan Nephew

class dart::mdct_dev9 inherits dart::abstract::workstation_node {

    include 'dart::abstract::idea'
    include 'dart::subsys::yum_cron'
    iptables::tcp_port {
        'picapswebui-local': port => '8180';
        'synergy': port => '24800';
        'rmi': port => '1099';
        'xml': port => '8183';
        'replication': port => '51190';
    }

}
