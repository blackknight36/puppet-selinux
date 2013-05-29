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
password=T1c!3P01
',
    }

    $tcadmins_gid = '54321'
    group { 'tcadmins':
        gid     => $tcadmins_gid,
        system  => false,
    }

    # Users defined in Active Directory; this just for group membership since
    # the 'groupadd' provider for the group type (above) does not support
    # membership management.
    user { ['d74326', 'd850293']:
        groups  => 'tcadmins',
        require => Group['tcadmins'],
    }

    define mounted_tc_volume ($host, $share_name,
                              $owner='root', $group='root', $mode='0775',
                              $options='ro')
    {

        file { "/srv/${host}-${share_name}":
            ensure  => directory,
            owner   => "${owner}",
            group   => "${group}",
            mode    => "${mode}",
        }

        mount { "/srv/${host}-${share_name}":
            atboot  => true,
            device  => "//${host}/${share_name}",
            ensure  => 'mounted',
            fstype  => 'cifs',
            options => "${options},credentials=/etc/tc-credentials,dir_mode=${mode}",
            require => [
                File['/etc/tc-credentials'],
                File["/srv/${host}-${share_name}"],
            ],
        }

    }

    mounted_tc_volume { 'teamcenter_source':
        host            => 'mas-cad10',
        share_name      => 'volumes',
        mode            => '0555',
    }

    mounted_tc_volume { 'teamcenter_preproduction_alpha':
        host            => 'mas-cad16',
        share_name      => 'volumes',
        group           => "${tcadmins_gid}",
        options         => "rw,uid=0,gid=${tcadmins_gid},file_mode=0660,noperm",
        require         => Group['tcadmins'],
    }

    mounted_tc_volume { 'teamcenter_renumber_test':
        host            => 'mas-cad23',
        share_name      => 'volumes',
        group           => "${tcadmins_gid}",
        options         => "rw,uid=0,gid=${tcadmins_gid},file_mode=0660,noperm",
        require         => Group['tcadmins'],
    }

    mounted_tc_volume { 'teamcenter_preproduction_beta':
        host            => 'mas-cad26',
        share_name      => 'volumes',
        group           => "${tcadmins_gid}",
        options         => "rw,uid=0,gid=${tcadmins_gid},file_mode=0660,noperm",
        require         => Group['tcadmins'],
    }

    mounted_tc_volume { 'teamcenter_preproduction_gamma':
        host            => 'mas-cad27',
        share_name      => 'volumes',
        group           => "${tcadmins_gid}",
        options         => "rw,uid=0,gid=${tcadmins_gid},file_mode=0660,noperm",
        require         => Group['tcadmins'],
    }

    file { '/usr/local/bin/teamcenter-sync':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        source  => 'puppet:///modules/dart/tc-util/teamcenter-sync',
    }

}
