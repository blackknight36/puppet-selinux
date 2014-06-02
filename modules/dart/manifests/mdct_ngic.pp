# modules/dart/manifests/mdct_ngic.pp
#
# Synopsis:
#       NGIC Materials Database (production)
#
# Contact:
#       Ben Minshall

class dart::mdct_ngic inherits dart::abstract::ngic_server_node {

    class { 'bacula::client':
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => 'jJwusfSjdlflSdFe23rtunxNnsnsdeif9939HyL3ds',
        mon_name    => $dart::params::bacula_mon_name,
        mon_passwd  => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }
}
