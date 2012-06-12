# modules/dart/manifests/classes/mdct-00tl.pp

class dart::mdct-00tl inherits dart::abstract::server_node {

    class { 'iptables':
        enabled => true,
    }

    $bacula_client_director_password = "VrLkRkBWWIhDHF8ARkPfGH5mNWnF1wZd939DmfFAhNzS"
    $bacula_client_director_monitor_password = "8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU"
    include bacula::client

    lokkit::tcp_port {
            'http':                 port => '80';
    }

}
