# modules/dart/manifests/mdct_98pi.pp
#
# Synopsis:
#       PICAPS TestPlant98 server
#
# Contact:
#       Chris Kennedy

class dart::mdct_98pi inherits dart::abstract::picaps_production_server_node {

    class { '::network':
        service => 'legacy',
    }

    network::interface { 'em1':
        template   => 'static',
        ip_address => '10.1.192.149',
        netmask    => '255.255.0.0',
        gateway    => '10.1.0.25',
    }

}
