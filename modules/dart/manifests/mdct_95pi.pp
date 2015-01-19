# modules/dart/manifests/mdct_95pi.pp
#
# Synopsis:
#       PICAPS Mason Building 5 (MB5) server
#
# Contact:
#       Chris Kennedy

class dart::mdct_95pi inherits dart::abstract::picaps_production_server_node {

    #class { 'network':
    #    service         => 'legacy',
    #    domain          => $dart::params::dns_domain,
    #    name_servers    => $dart::params::dns_servers,
    #}

    #network::interface { 'em1':
    #    template    => 'static',
    #    ip_address  => '10.1.192.149',
    #    netmask     => '255.255.0.0',
    #    gateway     => '10.1.0.25',
    #}

}
