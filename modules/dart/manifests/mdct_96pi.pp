# modules/dart/manifests/mdct_96pi.pp
#
# Synopsis:
#       PICAPS live server for Corporate
#
# Contact:
#       Nathan Nephew

class dart::mdct_96pi inherits dart::abstract::picaps_production_server_node {

    class { 'network':
        service         => 'legacy',
        domain          => $dart::params::dns_domain,
        name_servers    => $dart::params::dns_servers,
    }

    network::interface { 'em1':
        template    => 'static',
        ip_address  => '10.1.192.147',
        netmask     => '255.255.0.0',
        gateway     => '10.1.0.25',
    }

}
