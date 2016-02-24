# modules/dart/manifests/mdct_dr.pp
#
# Synopsis:
#       Design Review application (production; serves Machine Design group)
#
# Contact:
#       Ben Minshall

class dart::mdct_dr inherits dart::abstract::dr_server_node {

    class { 'jaf_bacula::client':
        dir_name   => $dart::params::bacula_dir_name,
        dir_passwd => 'pEw3jdJle4QQwkdvSeofk4827DNVldkfjeiRslkDs3',
        mon_name   => $dart::params::bacula_mon_name,
        mon_passwd => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }

    class { '::network':
        service => 'legacy',
    }

    network::interface { 'eth0':
            template   => 'static',
            ip_address => '10.201.64.10',
            netmask    => '255.255.252.0',
            gateway    => '10.201.67.254',
            stp        => 'no',
    }
}
