# modules/dart/manifests/mdct_ngic.pp
#
# Synopsis:
#       NGIC Materials Database (production)
#
# Contact:
#       Ben Minshall

class dart::mdct_ngic inherits dart::abstract::ngic_server_node {

    class { 'jaf_bacula::client':
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => 'jJwusfSjdlflSdFe23rtunxNnsnsdeif9939HyL3ds',
        mon_name    => $dart::params::bacula_mon_name,
        mon_passwd  => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
    }

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }

    class { 'network':
            service         => 'legacy',
            domain          => $dart::params::dns_domain,
            name_servers    => $dart::params::dns_servers,
    }

    network::interface { 'eth0':
            template    => 'static',
            ip_address  => '10.201.64.8',
            netmask     => '255.255.252.0',
            gateway     => '10.201.67.254',
            stp         => 'no',
    }
}
