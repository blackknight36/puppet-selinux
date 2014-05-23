# modules/dart/manifests/mdct_dr.pp
#
# Synopsis:
#       Design Review application (production; serves Machine Design group)
#
# Contact:
#       Ben Minshall

class dart::mdct_dr inherits dart::abstract::dr_server_node {

    class { 'bacula::client':
        dir_name    => 'mdct-bacula-dir',
        dir_passwd  => 'pEw3jdJle4QQwkdvSeofk4827DNVldkfjeiRslkDs3',
        mon_name    => 'mdct-bacula-mon',
        mon_passwd  => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }
}
