# modules/dart/manifests/mdct_dr_dev.pp
#
# Synopsis:
#       Design Review application (test and development environment)
#
# Contact:
#       Ben Minshall

class dart::mdct_dr_dev inherits dart::abstract::dr_server_node {

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }
    class { 'network':
            service         => 'legacy',
            domain          => $dart::params::dns_domain,
            name_servers    => $dart::params::dns_servers,
    }

    network::interface { 'eth0':
            template    => 'static',
            ip_address  => '10.201.64.11',
            netmask     => '255.255.252.0',
            gateway     => '10.201.67.254',
            stp         => 'no',
    }
}
