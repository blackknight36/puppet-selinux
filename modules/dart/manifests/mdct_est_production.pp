# modules/dart/manifests/mdct_est_production.pp
#
# Synopsis:
#       EST data warehouse
#
# Contact:
#       Collin Baker

class dart::mdct_est_production inherits dart::abstract::est_server_node {

    class { 'bacula::client':
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => '83a2c60033d6d19a7148517653f32e78',
        mon_name    => $dart::params::bacula_mon_name,
        mon_passwd  => '68524754e65fe7d71aeb338c38ab0de1',
    }

    iptables::rules_file { 'est-nat':
        source  => 'puppet:///private-domain/iptables/est-nat',
        table   => 'nat',
    }


}
