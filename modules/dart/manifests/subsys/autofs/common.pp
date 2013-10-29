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
# [*legacy*]
#   To remain backwards compatible with extant setups, this should be set to
#   true (the default).  However, it is much preferred for newer setups to
#   have this false because it leads to a much cleaner and more flexible
#   configuration where, for example, /mnt can be used for more than just our
#   static "homes and pub" configuration.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::autofs::common ($legacy=true) {

    include 'autofs::params'

    class { 'autofs':
        legacy  => $legacy,
    }

    selinux::boolean { 'use_nfs_home_dirs':
        before      => Service[$autofs::params::service_name],
        persistent  => true,
        value       => on,
    }

    if $legacy {
        autofs::mount { 'home':
            source  => 'puppet:///modules/dart/autofs/auto.home',
        }

        autofs::mount { 'master':
            source  => "puppet:///modules/dart/autofs/auto.master",
        }

        autofs::mount { 'mnt':
            source  => 'puppet:///modules/dart/autofs/auto.mnt',
        }

        autofs::mount { 'mnt-local':
            source  => [
                'puppet:///private-host/autofs/auto.mnt-local',
                'puppet:///private-domain/autofs/auto.mnt-local',
                'puppet:///modules/dart/autofs/auto.mnt-local',
            ],
        }
    } else {

        autofs::mount_point { '/home/00':
            options => '--timeout=600',
        }

        autofs::map_entry { '/home/00/*':
            mount   => '/home/00',
            key     => '*',
            options => '-fstype=nfs4,rw,hard,intr,nosuid,relatime,fsc',
            remote  => 'mdct-00fs:/&',
        }

        autofs::mount_point { '/mnt':
            options => '--timeout=600 --ghost',
        }

        autofs::map_entry { '/mnt/pub':
            mount   => '/mnt',
            key     => 'pub',
            options => '-rw,hard,intr,nosuid,noatime,fsc',
            remote  => 'mdct-00fs:/storage/pub',
        }

        # TODO: migrate mnt-local

        # Purge legacy /etc/auto.<MOUNT_NAME> map files ...
        file { [ '/etc/auto.home', '/etc/auto.mnt']:
            ensure  => absent,
            notify  => Service[$autofs::params::service_name],
        }

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
