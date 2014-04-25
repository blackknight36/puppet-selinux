# modules/dart/manifests/mdct_02pi.pp
#
# Synopsis:
#       PICAPS live server for Leola
#
# Contact:
#       Chris Kennedy

class dart::mdct_02pi inherits dart::abstract::picaps_production_server_node {

    class { 'network':
        service         => 'legacy',
        domain          => 'dartcontainer.com',
        name_servers    => ['10.1.0.98', '10.1.0.99'],
    }

    #network::interface { 'em1':
    #    template    => 'static',
    #    ip_address  => '10.1.192.147',
    #    netmask     => '255.255.0.0',
    #    gateway     => '10.1.0.25',
    #}

}
