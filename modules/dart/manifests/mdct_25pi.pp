# modules/dart/manifests/mdct_25pi.pp
#
# Synopsis:
#       PICAPS live server for Tumwater
#
# Contact:
#       Chris Kennedy

class dart::mdct_25pi inherits dart::abstract::picaps_production_server_node {

    class { '::network':
        service => 'legacy',
    }

    #network::interface { 'em1':
    #    template    => 'static',
    #    ip_address  => '10.1.192.151',
    #    netmask     => '255.255.0.0',
    #    gateway     => '10.1.0.25',
    #}

}
