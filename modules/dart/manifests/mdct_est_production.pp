# modules/dart/manifests/mdct_est_production.pp
#
# Synopsis:
#       EST data warehouse
#
# Contact:
#       Collin Baker

class dart::mdct_est_production inherits dart::abstract::est_server_node {

    class { 'jaf_bacula::client':
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => '83a2c60033d6d19a7148517653f32e78',
        mon_name    => $dart::params::bacula_mon_name,
        mon_passwd  => '68524754e65fe7d71aeb338c38ab0de1',
    }
    class { 'network':
            service         => 'legacy',
            domain          => $dart::params::dns_domain,
            name_servers    => $dart::params::dns_servers,
    }

    network::interface { 'eth0':
            template    => 'static',
            ip_address  => '10.201.64.5',
            netmask     => '255.255.252.0',
            gateway     => '10.201.67.254',
            stp         => 'no',
    }

}
