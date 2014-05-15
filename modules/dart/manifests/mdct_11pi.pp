# modules/dart/manifests/mdct_11pi.pp
#
# Synopsis:
#       PICAPS live server for Horsecave
#
# Contact:
#       Chris Kennedy

class dart::mdct_11pi inherits dart::abstract::picaps_production_server_node {

    class { 'network':
        service         => 'legacy',
        domain          => 'dartcontainer.com',
        name_servers    => ['10.1.0.98', '10.1.0.99'],
    }

#    network::interface { 'em1':
#        template    => 'static',
#        ip_address  => '10.1.192.149',
#        netmask     => '255.255.0.0',
#        gateway     => '10.1.0.25',
#    }

}
