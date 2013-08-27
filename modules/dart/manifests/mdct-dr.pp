# modules/dart/manifests/mdct-dr.pp
#
# Synopsis:
#       Design Review application (production; serves Machine Design group)
#
# Contact:
#       Ben Minshall

class dart::mdct-dr inherits dart::abstract::dr_server_node {

    class { 'bacula::client':
        dir_passwd      => 'pEw3jdJle4QQwkdvSeofk4827DNVldkfjeiRslkDs3',
        mon_passwd      => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }
}
