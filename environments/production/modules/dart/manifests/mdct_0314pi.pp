# modules/dart/manifests/mdct_0314pi.pp
#
# Synopsis:
#       PICAPS live server for Dallas
#
# Contact:
#       Nathan Nephew

class dart::mdct_0314pi inherits dart::abstract::picaps_production_server_node {

    #class { '::network':
    #    service => 'legacy',
    #}

    #network::interface { 'em1':
    #    template => 'static',
    #    ip_address  => '10.7.215.3',
    #    netmask     => '255.255.252.0',
    #    gateway     => '10.7.215.254',
    #}

}
