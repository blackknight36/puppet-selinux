# modules/dart/manifests/mdct-tc.pp

class dart::mdct-tc inherits dart::abstract::server_node {

    class { 'iptables':
        enabled => true,
    }

    include lokkit
    include postgresql::server
    include apache

    package { [ 'php', ]:
        ensure  => installed,
    }

    class { 'bacula::client':
        dir_passwd      => 'uUue45lLldkNNhfla3jf9dkfjxxDkfjAldkfjLKDJE',
        mon_passwd      => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    lokkit::tcp_port {
        'postgres':             port => '5432';
    }
}
