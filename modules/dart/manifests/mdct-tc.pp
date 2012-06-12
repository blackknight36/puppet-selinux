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

    lokkit::tcp_port {
        'postgres':             port => '5432';
    }
}
