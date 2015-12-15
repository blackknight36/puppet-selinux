# modules/dart/manifests/mdct_dev17.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Collin Baker

class dart::mdct_dev17 inherits dart::abstract::workstation_node {

    include 'dart::subsys::yum_cron'
    include 'dart::abstract::idea'

    iptables::tcp_port {
        'tomcat': port => '8080';
    }

    include '::network'

network::interface { 'em1':
        template    => 'static',
        ip_address  => '10.209.44.17',
        netmask     => '255.255.252.0',
        gateway     => '10.209.47.254',
        stp         => 'no',
    }

}
