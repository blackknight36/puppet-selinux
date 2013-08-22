# modules/dart/manifests/mdct-0302pi.pp
#
# Synopsis:
#       PICAPS live server for Federalsburg
#
# Contact:
#       Nathan Nephew

class dart::mdct-0302pi inherits dart::abstract::picaps_production_server_node {

    #class { 'network':
    #    network_manager => false,
    #    domain => 'dartcontainer.com',
    #    name_servers => ['10.1.0.98','10.1.0.99'],
    #}

    #network::interface { 'em1':
    #    template => 'static',
    #    ip_address  => '10.7.87.3',
    #    netmask     => '255.255.252.0',
    #    gateway     => '10.7.87.254',
    #}

}
