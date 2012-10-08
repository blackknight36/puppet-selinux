# modules/dart/manifests/tc-util.pp

class dart::tc-util inherits dart::abstract::server_node {

    include packages::developer
    include yum-cron

    file { '/etc/tc-credentials':
        owner   => 'root',
        group   => 'root',
        mode    => '0400',
        content => 'domain=MASON_NTD
username=tcadmin
password=Tc_admin1a
',
    }

    define mounted_tc_volume ($host, $share_name, $owner='root', $options='ro') {

        file { "/srv/${host}-${share_name}":
            ensure  => directory,
            owner   => "${owner}",
            group   => 'root',
            mode    => '0755',
        }

        mount { "/srv/${host}-${share_name}":
            atboot  => true,
            device  => "//${host}/${share_name}",
            ensure  => 'mounted',
            fstype  => 'cifs',
            options => "${options},credentials=/etc/tc-credentials",
            require => [
                File['/etc/tc-credentials'],
                File["/srv/${host}-${share_name}"],
            ],
        }

    }

    mounted_tc_volume { 'sync_source':
        host            => 'mas-cad10',
        share_name      => 'volumes',
    }

    mounted_tc_volume { 'sync_target':
        host            => 'mas-cad16',
        share_name      => 'volumes',
        owner           => 'd74326',
        options         => 'rw,uid=d74326',
    }

    file { '/usr/local/bin/teamcenter-sync':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        source  => 'puppet:///modules/dart/tc-util/teamcenter-sync',
    }

}
