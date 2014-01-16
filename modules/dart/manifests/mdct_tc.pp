# modules/dart/manifests/mdct_tc.pp
#
# Synopsis:
#       PostgreSQL support server for Teamcenter migration process
#
# Contact:
#       Ben Minshall

class dart::mdct_tc inherits dart::abstract::guarded_server_node {

    include 'apache'
    include 'postgresql::server'

    class { 'puppet::client':
    }


    package { [ 'php', ]:
        ensure  => installed,
    }

    class { 'bacula::client':
        dir_passwd      => 'uUue45lLldkNNhfla3jf9dkfjxxDkfjAldkfjLKDJE',
        mon_passwd      => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    iptables::tcp_port {
        'postgres': port => '5432';
    }
}
