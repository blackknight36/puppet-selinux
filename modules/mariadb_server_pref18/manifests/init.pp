# modules/mariadb_server_pref18/manifests/init.pp

class mariadb_server_pref18 {

    file { "/etc/yum.repos.d/MariaDB.repo":
        group   => "root",
        mode    => 644,
        owner   => "root",
        source  => [
            'puppet:///private-host/etc/yum.repos.d/MariaDB.repo',
            'puppet:///modules/mariadb_server_pref18/MariaDB.repo',
        ],
    }

    $key_store="http://mdct-00fs.dartcontainer.com/pub/fedora/mdct/signing_keys"

    exec { "import_mariadb_signing_key":
        command => "rpm --import $key_store/RPM-GPG-KEY-MariaDB",
        unless  => "rpm -q gpg-pubkey-1bb943db-4b688490",
    }

    define mariadb_package ($source) {
        package { $name:
            ensure      => installed,
            #provider   => 'rpm',
            require     => [
                File["/etc/yum.repos.d/MariaDB.repo"],
                Exec["import_mariadb_signing_key"],
            ],
            #source     => $source,
        }
    }

    mariadb_package { "MariaDB-common":
        source  => $operatingsystemrelease ? {
            16 => 'http://mdct-00fs/pub/mariadb/mariadb-5.5.28/fedora16-amd64/rpms/MariaDB-5.5.28-fedora16-x86_64-common.rpm',
            17 => 'http://mdct-00fs/pub/mariadb/mariadb-5.5.28/fedora17-amd64/rpms/MariaDB-5.5.28-fedora17-x86_64-common.rpm',
        }
    }

    mariadb_package { "MariaDB-client":
        source  => $operatingsystemrelease ? {
            16 => 'http://mdct-00fs/pub/mariadb/mariadb-5.5.28/fedora16-amd64/rpms/MariaDB-5.5.28-fedora16-x86_64-client.rpm',
            17 => 'http://mdct-00fs/pub/mariadb/mariadb-5.5.28/fedora17-amd64/rpms/MariaDB-5.5.28-fedora17-x86_64-client.rpm',
        },
        require => [
            Package[ "MariaDB-common" ],
        ],
    }

    mariadb_package { "MariaDB-server":
        source      => $operatingsystemrelease ? {
            16 => 'http://mdct-00fs/pub/mariadb/mariadb-5.5.28/fedora16-amd64/rpms/MariaDB-5.5.28-fedora16-x86_64-server.rpm',
            17 => 'http://mdct-00fs/pub/mariadb/mariadb-5.5.28/fedora17-amd64/rpms/MariaDB-5.5.28-fedora17-x86_64-server.rpm',
        },
        require => [
            Package[ "MariaDB-common" ],
        ],
    }

    file { "/etc/my.cnf":
        group   => "root",
        mode    => 644,
        owner   => "root",
        source  => [
            'puppet:///private-host/etc/my.cnf',
            'puppet:///modules/mariadb_server_pref18/my.cnf',
        ],
    }


    service { "mysql":
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        require     => [
            Package[ "MariaDB-server" ],
            File["/etc/my.cnf"],
        ],
        subscribe   => [
            File["/etc/my.cnf"],
        ]

    }

}
