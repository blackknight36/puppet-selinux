# modules/dart/manifests/mdct_00pirm.pp
#
# Synopsis:
#       PICAPS live server for reelication
#
# Contact:
#       Nathan Nephew

class dart::mdct_00pirm inherits dart::abstract::picaps_production_server_node {

    #class { '::network':
    #    service => 'legacy',
    #}

    #network::interface { 'em1':
    #    template => 'static',
    #    ip_address  => '10.7.87.3',
    #    netmask     => '255.255.252.0',
    #    gateway     => '10.7.87.254',
    #}

}
