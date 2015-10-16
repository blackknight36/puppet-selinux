# modules/dart/manifests/mdct_nexus.pp
#
# Synopsis:
#       Sonatype Nexus server for Maven builds.
#
# Contact:
#       Levi Harper

class dart::mdct_nexus inherits dart::abstract::guarded_server_node {

    include 'apache'

    class { 'jaf_bacula::client':
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => 'v1OUZExhC5RwX6VtphBlrD61PI1XrlwVZH7yMFCVy1Yj',
        mon_name    => $dart::params::bacula_mon_name,
        mon_passwd  => 'rlgfP6nL1RbmTV7MiSJqOPSEp5Uh06J5aeon9fOk93i1',
    }

    # This package allows optimal performance in production environments.
    package { 'tomcat-native':
        ensure  => installed,
    }

    class { 'network':
            service         => 'nm',
            domain          => $dart::params::dns_domain,
            name_servers    => $dart::params::dns_servers,
    }

    network::interface { 'eth0':
            template    => 'static',
            ip_address  => '10.201.64.20',
            netmask     => '255.255.252.0',
            gateway     => '10.201.67.254',
            stp         => 'no',
    }
}
