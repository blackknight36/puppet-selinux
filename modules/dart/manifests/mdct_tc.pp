# modules/dart/manifests/mdct_tc.pp
#
# Synopsis:
#       PostgreSQL support server for Teamcenter migration process
#
# Contact:
#       Ben Minshall

class dart::mdct_tc inherits dart::abstract::guarded_server_node {

    include 'apache'

    class { 'postgresql::server':
        hba_conf    => 'puppet:///private-host/postgresql/pg_hba.conf',
    }

    class { 'puppet::client':
    }


    package { [ 'php', ]:
        ensure  => installed,
    }

    class { 'bacula::client':
        dir_name    => 'mdct-bacula-dir',
        dir_passwd  => 'uUue45lLldkNNhfla3jf9dkfjxxDkfjAldkfjLKDJE',
        mon_name    => 'mdct-bacula-mon',
        mon_passwd  => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    iptables::tcp_port {
        'postgres': port => '5432';
    }
}
