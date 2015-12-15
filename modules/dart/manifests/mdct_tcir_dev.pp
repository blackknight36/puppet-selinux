# modules/dart/manifests/mdct_tcir_dev.pp
#
# Synopsis:
#       (TCIR) Toolcrib Inventory Review Database (development)
#
# Contact:
#       Ben Minshall

class dart::mdct_tcir_dev inherits dart::abstract::tcir_server_node {

#    class { 'jaf_bacula::client':
#        dir_name    => $dart::params::bacula_dir_name,
#        dir_passwd  => 'jJwusfSjdlflSdFe23rtunxNnsnsdeif9939HyL3ds',
#        mon_name    => $dart::params::bacula_mon_name,
#        mon_passwd  => '8QNsZ1MehmXv61Kx8l2IcnOhtjrXeV3iFBm3GNOqukMU',
#    }

    iptables::tcp_port {
        'postgresql':   port => '5432';
    }

    iptables::tcp_port {
        'bacula_fd': port => '9102';
    }


    file { '/var/lib/bacula/ssl':
        ensure  =>  directory,
        recurse =>  true,
        source  =>  'file:/var/lib/puppet/ssl',
        owner   =>  'bacula',
        group   =>  'bacula',
    }

    class { '::bacula':
        is_client         =>  true,
        director_server   =>  'mdct-00bk-f21.dartcontainer.com',
        director_password =>  'test',
        storage_server    =>  'mdct-00bk-f21.dartcontainer.com',
        use_tls           =>  true,
        tls_ca_cert       =>  '/var/lib/bacula/ssl/certs/ca.pem',
        tls_key           =>  "/var/lib/bacula/ssl/private_keys/${::fqdn}.pem",
        tls_cert          =>  "/var/lib/bacula/ssl/certs/${::fqdn}.pem",
        tls_require       =>  'yes',
        tls_verify_peer   =>  'yes',
    }

    class { '::network':
        service => 'legacy',
    }

    network::interface { 'eth0':
            template   => 'static',
            ip_address => '10.201.64.13',
            netmask    => '255.255.252.0',
            gateway    => '10.201.67.254',
            stp        => 'no',
    }
}
