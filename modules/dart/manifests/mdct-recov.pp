# modules/dart/manifests/mdct-recov.pp

class dart::mdct-recov inherits dart::abstract::picaps_production_server_node {

    class { 'network':
        network_manager => false,
        domain => 'dartcontainer.com',
        name_servers => ['10.1.0.98','10.1.0.99'],
    }

    network::interface { 'em1':
        template => 'static',
        ip_address  => '10.1.192.156',
        netmask     => '255.255.0.0',
        gateway     => '10.1.0.25',
    }

}
