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

    file { '/srv/mas-cad10-volumes':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
    }

    mount { '/srv/mas-cad10-volumes':
        atboot  => true,
        device  => '//mas-cad10/volumes',
        ensure  => 'mounted',
        fstype  => 'cifs',
        options => 'ro,credentials=/etc/tc-credentials',
        require => [
            File['/etc/tc-credentials'],
            File['/srv/mas-cad10-volumes'],
        ],
    }

    file { '/srv/mas-cad16-volumes':
        ensure  => directory,
        owner   => 'd74326',
        group   => 'root',
        mode    => '0755',
    }

    mount { '/srv/mas-cad16-volumes':
        atboot  => true,
        device  => '//mas-cad16/volumes',
        ensure  => 'mounted',
        fstype  => 'cifs',
        options => 'rw,uid=d74326,credentials=/etc/tc-credentials',
        require => [
            File['/etc/tc-credentials'],
            File['/srv/mas-cad16-volumes'],
        ],
    }

    file { '/usr/local/bin/teamcenter-sync':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        source  => 'puppet:///modules/dart/tc-util/teamcenter-sync',
    }

}
