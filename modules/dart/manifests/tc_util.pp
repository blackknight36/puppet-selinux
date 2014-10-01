# modules/dart/manifests/tc_util.pp
#
# Synopsis:
#       General purpose utility server for TeamCenter
#
# Contact:
#       John Florian

class dart::tc_util inherits dart::abstract::guarded_server_node {

    tag 'tc_util'

    include 'dart::abstract::packages::developer'

    class { 'puppet::client':
    }

    include 'dart::subsys::yum_cron'

    #
    ##
    ### TeamCenter Sync Support
    ##
    #

    $credentials_fn = '/etc/tc-credentials'

    file { $credentials_fn:
        owner   => 'root',
        group   => 'root',
        mode    => '0400',
        content => 'domain=MASON_NTD
username=tcservices
password=T5A!ENsER
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

    # Mount defaults are idealized for sync targets since they number more
    # than sync sources.  Some parameters may not even be necessary for
    # sources, but may exist here if harmless or if overrided.
    Dart::Subsys::Teamcenter::Mount {
        group   => $tcadmins_gid,
        options => "rw,uid=0,gid=${tcadmins_gid},file_mode=0660,noperm,credentials=${credentials_fn}",
        require => [
            File[$credentials_fn],
            Group['tcadmins'],
        ],
    }

    # Sync Sources
    dart::subsys::teamcenter::mount { 'teamcenter_source':
        host        => 'mas-cad10',
        share_name  => 'volumes',
        group       => 'root',
        mode        => '0555',
        options     => "credentials=${credentials_fn}",
    }

    # Sync Targets
    dart::subsys::teamcenter::mount {
        'teamcenter_renumber_test':
            host        => 'mas-cad23',
            share_name  => 'volumes';

        'teamcenter_preproduction_beta':
            host        => 'mas-cad26',
            share_name  => 'volumes';

        'teamcenter_preproduction_delta':
            host            => 'mas-cad55',
            share_name      => 'volumes';
    }

    file { '/usr/local/bin/teamcenter-sync':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        source  => 'puppet:///modules/dart/tc_util/teamcenter-sync',
    }

    #
    ##
    ### TeamCenter Git Repository Support
    ##
    #

    file { '/storage':
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'file_t',
    }

    mount { '/storage':
        ensure  => 'mounted',
        atboot  => true,
        device  => '/dev/mapper/vg_tcutil-lv_storage',
        dump    => 1,
        fstype  => 'ext4',
        options => 'defaults',
        pass    => 2,
        require => File['/storage'],
    }

    file { '/srv/git_home':
        ensure  => 'directory',
        # Nothing else managed since the values will differ before/after the
        # mount below occurs, which confuses puppet.
    }

    mount { '/srv/git_home':
        ensure  => 'mounted',
        atboot  => true,
        device  => '/storage/git_home',
        fstype  => 'none',
        options => 'bind',
        require => [
            File['/srv/git_home'],
            Mount['/storage'],
        ],
    }

}
