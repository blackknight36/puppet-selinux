# modules/dart/manifests/subsys/autofs/common.pp
#
# == Class: dart::subsys::autofs::common
#
# Configures the autofs auto-mounter on a host for typical Dart usage.  This
# class (or some derivative of it) should be used instead of including the
# basic 'autofs' class directly.  The 'autofs' class is to manage the package,
# service and generalized configuration but is to remain agnostic of any
# specific mount details; those details belong here.
#
# === Parameters
#
# None
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::autofs::common {

    include 'autofs::params'

    class { 'autofs':
        require => [
            Class['authconfig'],
            Class['nfs::client'],
        ],
    }

    selinux::boolean { 'use_nfs_home_dirs':
        before      => Service[$autofs::params::service_name],
        persistent  => true,
        value       => on,
    }

    autofs::mount_point { '/home/00':
        options => '--timeout=600',
    }

    autofs::map_entry { '/home/00/*':
        mount   => '/home/00',
        key     => '*',
        options => '-nfsvers=4,sec=sys,rw,hard,intr,nosuid,relatime',
        remote  => 'mdct-00fs:/&',
    }

    autofs::mount_point { '/mnt':
        options => '--timeout=600 --ghost',
    }

    # TODO: use NFSv4
    #   - /etc/exports will need fsid=0
    #   - What will the impact be on ACLs (e.g., /pub/fedora/mdct/) from the
    #   client perspective?
    #   - What about bind mounts exposed through /pub (e.g.,
    #   /storage/projects)?
    autofs::map_entry { '/mnt/pub':
        mount   => '/mnt',
        key     => 'pub',
        options => '-nfsvers=3,rw,hard,intr,nosuid,noatime',
        remote  => 'mdct-00fs:/storage/pub',
    }

    if $::operatingsystemrelease < 19 {
        # Older versions of puppet and/or Fedora prevent the SELinux context
        # from actually changing, so don't even try as it otherwise generates
        # an endless stream of tagmail.
        file { '/pub':
            ensure  => link,
            target  => '/mnt/pub',
        }
    } else {
        file { '/pub':
            ensure  => link,
            target  => '/mnt/pub',
            seluser => 'system_u',
            selrole => 'object_r',
            seltype => 'nfs_t',
        }
    }

}
