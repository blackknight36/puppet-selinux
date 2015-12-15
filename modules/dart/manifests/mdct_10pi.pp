# modules/dart/manifests/mdct_10pi.pp
#
# Synopsis:
#       PICAPS live server for Waxahachie
#
# Contact:
#       Chris Kennedy

class dart::mdct_10pi inherits dart::abstract::picaps_production_server_node {

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
