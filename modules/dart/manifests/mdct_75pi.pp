# modules/dart/manifests/mdct_75pi.pp
#
# Synopsis:
#       PICAPS live server for England
#
# Contact:
#       Chris Kennedy

class dart::mdct_75pi inherits dart::abstract::picaps_production_server_node {

    class { 'network':
        service         => 'legacy',
        domain          => $dart::params::dns_domain,
        name_servers    => $dart::params::dns_servers,
    }

#    network::interface { 'em1':
#        template    => 'static',
#        ip_address  => '10.1.192.149',
#        netmask     => '255.255.0.0',
#        gateway     => '10.1.0.25',
#    }

}
