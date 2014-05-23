# modules/dart/manifests/mdct_00tl.pp
#
# Synopsis:
#       TestLink server (production)
#
# Contact:
#       Nathan Nephew

class dart::mdct_00tl inherits dart::abstract::semi_guarded_server_node {

    class { 'bacula::client':
        dir_name    => 'mdct-bacula-dir',
        dir_passwd  => 'VrLkRkBWWIhDHF8ARkPfGH5mNWnF1wZd939DmfFAhNzS',
        mon_name    => 'mdct-bacula-mon',
        mon_passwd  => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    class { 'puppet::client':
    }

    iptables::tcp_port {
        'http': port => '80';
    }

}
