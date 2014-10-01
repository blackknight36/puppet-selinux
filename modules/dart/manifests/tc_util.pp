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
    include 'dart::subsys::teamcenter::sync'

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
