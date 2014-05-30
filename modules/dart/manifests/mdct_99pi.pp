# modules/dart/manifests/mdct_99pi.pp
#
# Synopsis:
#       PICAPS test server for TestPlant99 
#
# Contact:
#       Chris Kennedy

class dart::mdct_99pi inherits dart::abstract::picaps_production_server_node {

    #class { 'network':
    #    network_manager => false,
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
