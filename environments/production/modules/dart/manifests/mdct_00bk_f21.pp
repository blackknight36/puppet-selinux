# modules/dart/manifests/mdct_00bk_f21.pp
#
# Synopsis:
#       Bacula backup system (director & storage daemons)
#
# Contact:
#       John Florian
#       Levi Harper

class dart::mdct_00bk_f21 inherits dart::abstract::guarded_server_node {

#    include '::network'

#    network::interface { 'ens32':
#        template    => 'static',
#        ip_address  => '10.1.250.47',
#        netmask     => '255.255.0.0',
#        gateway     => '10.1.0.25',
#        stp         => 'no',
#    }

#    network::interface { 'ens34':
#        template    => 'static',
#        ip_address  => '192.168.1.7',
#        netmask     => '255.255.255.0',
#        stp         => 'no',
#    }

    file { '/storage':
        ensure  => directory,
    }

    file { '/var/lib/bacula/ssl':
        ensure  =>  directory,
        recurse =>  true,
        source  =>  'file:/var/lib/puppet/ssl',
        owner   =>  'bacula',
        group   =>  'bacula',
    }


    class { '::postgresql::server':
    }

    $bacula_clients = {
        "${::fqdn}" => {
            client_schedule =>  'WeeklyCycle',
            fileset         =>  'Basic:noHome',
            director_password   =>  'test',
            director_server =>  $::fqdn,
            use_tls         =>  true,
            tls_ca_cert     =>  '/var/lib/bacula/ssl/certs/ca.pem',
            tls_key         =>  "/var/lib/bacula/ssl/private_keys/${::fqdn}.pem",
            tls_cert        =>  "/var/lib/bacula/ssl/certs/${::fqdn}.pem",
            tls_require     =>  'yes',
        },
        '10.201.64.2' => {
            client_schedule =>  'WeeklyCycle',
            fileset         =>  'Basic:noHome',
            director_password   =>  'test',
            director_server =>  $::fqdn,
            use_tls         =>  true,
            tls_ca_cert     =>  '/var/lib/bacula/ssl/certs/ca.pem',
            tls_key         =>  "/var/lib/bacula/ssl/private_keys/${::fqdn}.pem",
            tls_cert        =>  "/var/lib/bacula/ssl/certs/${::fqdn}.pem",
            tls_require     =>  'yes',
        },
        'mdct-tcir-dev.dartcontainer.com' => {
            client_schedule =>  'WeeklyCycle',
            fileset         =>  'Basic:noHome',
            director_password   =>  'test',
            director_server =>  $::fqdn,
            use_tls         =>  true,
            tls_ca_cert     =>  '/var/lib/bacula/ssl/certs/ca.pem',
            tls_key         =>  "/var/lib/bacula/ssl/private_keys/${::fqdn}.pem",
            tls_cert        =>  "/var/lib/bacula/ssl/certs/${::fqdn}.pem",
            tls_require     =>  'yes',
        },
    }



    class { '::bacula':
        clients               =>  $bacula_clients,
        is_client             =>  true,
        is_director           =>  true,
        is_storage            =>  true,
        director_server       =>  $::fqdn,
        director_password     =>  'test',
        console_password      =>  'test',
        mail_to               =>  'd35110@dart.biz',
        manage_console        =>  true,
        storage_server        =>  'mdct-00bk-f21.dartcontainer.com',
        db_backend            =>  'postgresql',
        use_tls               =>  true,
        tls_ca_cert           =>  '/var/lib/bacula/ssl/certs/ca.pem',
        tls_key               =>  "/var/lib/bacula/ssl/private_keys/${::fqdn}.pem",
        tls_cert              =>  "/var/lib/bacula/ssl/certs/${::fqdn}.pem",
        tls_require           =>  'yes',
        tls_verify_peer       =>  'yes',
        manage_db             =>  true,
        manage_db_tables      =>  true,
        backup_catalog        =>  false,
        db_user               =>  'bacula',
        db_password           =>  'bacula',
        storage_default_mount =>  '/storage/volumes',
    }
}
