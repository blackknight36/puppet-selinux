# modules/dart/manifests/mdct_0302pt.pp
#
# Synopsis:
#       PICAPS test server for Federalsburg
#
# Contact:
#       Nathan Nephew

class dart::mdct_0302pt inherits dart::abstract::picaps_test_server_node {

    #class { 'network':
    #    network_manager => false,
    #    domain => $dart::params::dns_domain,
    #    name_servers => $dart::params::dns_servers,
    #}

    #network::interface { 'em1':
    #    template => 'static',
    #    ip_address  => '10.7.87.3',
    #    netmask     => '255.255.252.0',
    #    gateway     => '10.7.87.254',
    #}

}
