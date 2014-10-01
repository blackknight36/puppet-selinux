# modules/dart/manifests/subsys/teamcenter/git.pp
#
# == Class: dart::subsys::teamcenter::git
#
# Configures a host to provide a Git repository for the TeamCenter users.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::teamcenter::git {

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
