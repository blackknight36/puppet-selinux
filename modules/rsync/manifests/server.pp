# modules/rsync/manifests/server.pp
#
# == Class: rsync::server
#
# Configures a host as a rsync server.
#
# === Parameters
#
# [*content*]
#   Literal content for the rsync daemon configuration file.  One and only one
#   of "content" or "source" must be given.
#
# [*source*]
#   URI of the rsync daemon configuration file content.  One and only one of
#   "content" or "source" must be given.
#
# [*xinetd_source*]
#   URI of the xinetd service file content for the rsync daemon.  The default
#   provides a basic configuration, but this parameter may be used to override
#   the default.
#
# [*export_all_ro*]
#   Manage SELinux to allow rsync to export any files/directories read only.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class rsync::server (
        $content=undef, $source=undef, $xinetd_source=undef,
        $export_all_ro=false,
    ) {

    include 'rsync'
    include 'rsync::params'
    include 'xinetd'

    xinetd::service { 'rsync':
        source  => $xinetd_source ? {
            undef   => 'puppet:///modules/rsync/rsync.xinetd',
            default => $xinetd_source,
        },
    }

    file { '/etc/rsyncd.conf':
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'rsync_etc_t',
        before      => Service[$xinetd::params::service_name],
        notify      => Service[$xinetd::params::service_name],
        content => $content,
        source  => $source,
    }

    iptables::tcp_port {
        'rsync': port => '873';
    }

    Selinux::Boolean {
        persistent  => true,
    }

    selinux::boolean {
        $rsync::params::bool_export_all_ro:
            value       => $export_all_ro ? {
                true    => 'on',
                default => 'off',
            };
    }

}
