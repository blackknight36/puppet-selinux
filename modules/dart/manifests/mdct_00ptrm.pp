# modules/dart/manifests/mdct_00ptrm.pp
#
# Synopsis:
#       PICAPS test server for replication 
#
# Contact:
#       Nathan Nephew

class dart::mdct_00ptrm inherits dart::abstract::picaps_test_server_node {

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
