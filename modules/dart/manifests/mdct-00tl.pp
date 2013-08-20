# modules/dart/manifests/mdct-00tl.pp
#
# Synopsis:
#       TestLink server (production)
#
# Contact:
#       Nathan Nephew

class dart::mdct-00tl inherits dart::abstract::server_node {

    class { 'iptables':
        enabled => true,
    }

    class { 'bacula::client':
        dir_passwd      => 'VrLkRkBWWIhDHF8ARkPfGH5mNWnF1wZd939DmfFAhNzS',
        mon_passwd      => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    class { 'puppet::client':
    }

    lokkit::tcp_port {
            'http':                 port => '80';
    }

}
