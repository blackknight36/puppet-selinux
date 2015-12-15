# modules/dart/manifests/mdct_est_dev2.pp
#
# Synopsis:
#       EST testing and development environment
#
# Contact:
#       Ben Minshall

class dart::mdct_est_dev2 inherits dart::abstract::est_server_node {

    class { '::network':
        service => 'legacy',
    }

network::interface { 'eth0':
        template    => 'static',
        ip_address  => '10.201.64.7',
        netmask     => '255.255.252.0',
	gateway     => '10.201.67.254',
        stp         => 'no',
    }

}
