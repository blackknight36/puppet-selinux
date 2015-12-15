# modules/dart/manifests/mdct_recov.pp
#
# Synopsis:
#       PICAPS disaster recovery planning and testing
#
# Contact:
#       Nathan Nephew

class dart::mdct_recov inherits dart::abstract::picaps_production_server_node {

    class { '::network':
        service => 'legacy',
    }

    network::interface { 'em1':
        template   => 'static',
        ip_address => '10.1.192.156',
        netmask    => '255.255.0.0',
        gateway    => '10.1.0.25',
    }

}
