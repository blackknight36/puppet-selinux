# modules/dart/manifests/mdct_05pi.pp
#
# Synopsis:
#       PICAPS live server for Corona
#
# Contact:
#       Chris Kennedy

class dart::mdct_05pi inherits dart::abstract::picaps_production_server_node {

    class { '::network':
        service => 'legacy',
    }

#    network::interface { 'em1':
#        template    => 'static',
#        ip_address  => '10.1.192.149',
#        netmask     => '255.255.0.0',
#        gateway     => '10.1.0.25',
#    }

}
