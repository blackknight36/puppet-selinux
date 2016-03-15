# modules/dart/manifests/mdct_00tl.pp
#
# Synopsis:
#       TestLink server (production)
#
# Contact:
#       Nathan Nephew

class dart::mdct_00tl inherits dart::abstract::semi_guarded_server_node {

    class { 'jaf_bacula::client':
        dir_name   => $dart::params::bacula_dir_name,
        dir_passwd => 'VrLkRkBWWIhDHF8ARkPfGH5mNWnF1wZd939DmfFAhNzS',
        mon_name   => $dart::params::bacula_mon_name,
        mon_passwd => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    iptables::tcp_port {
        'http': port => '80';
    }

    class { '::network':
        service         => 'legacy',
    }

    network::interface { 'eth0':
        template   => 'static',
        ip_address => '10.201.64.15',
        netmask    => '255.255.252.0',
        gateway    => '10.201.67.254',
        stp        => 'no',
    }

}