# modules/dart/manifests/mdct_est_dev1.pp
#
# Synopsis:
#       EST testing and development environment
#
# Contact:
#       Ben Minshall

class dart::mdct_est_dev1 inherits dart::abstract::est_server_node {

    iptables::tcp_port {
        'http': port => '80';
    }
    class { 'network':
            service         => 'legacy',
            domain          => $dart::params::dns_domain,
            name_servers    => $dart::params::dns_servers,
    }

    network::interface { 'eth0':
            template    => 'static',
            ip_address  => '10.201.64.6',
            netmask     => '255.255.252.0',
            gateway     => '10.201.67.254',
            stp         => 'no',
    }
}
