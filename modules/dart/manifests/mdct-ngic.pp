# modules/dart/manifests/mdct-ngic.pp
#
# Synopsis:
#       NGIC Materials Database (production)
#
# Contact:
#       Ben Minshall

class dart::mdct-ngic inherits dart::abstract::ngic_server_node {

    class { 'iptables':
        enabled => true,
    }

    class { 'bacula::client':
        dir_passwd      => 'jJwusfSjdlflSdFe23rtunxNnsnsdeif9939HyL3ds',
        mon_passwd      => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    lokkit::tcp_port {
        'postgresql':           port => '5432';
    }
}
