# modules/vsftpd/manifests/init.pp
#
# == Class: vsftpd
#
# Configures a host as a vsftpd server.
#
# === Parameters
#
# [*content*]
#   Literal content for the vsftpd.conf file.  One and only one of "content"
#   or "source" must be given.
#
# [*source*]
#   URI of the vsftpd.conf file content.  One and only one of "content" or
#   "source" must be given.
#
# [*allow_use_nfs*]
#   If true, configure SELinux to permit vsftpd to export content residing on
#   NFS.  The default is false.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class vsftpd($content=undef, $source=undef, $allow_use_nfs=false) {

    include 'vsftpd::params'

    package { $vsftpd::params::packages:
        ensure  => installed,
        notify  => Service[$vsftpd::params::service_name],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0600',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$vsftpd::params::service_name],
        notify      => Service[$vsftpd::params::service_name],
        subscribe   => Package[$vsftpd::params::packages],
    }

    file { '/etc/vsftpd/vsftpd.conf':
        content     => $content,
        source      => $source,
    }

    iptables::tcp_port {
        'vsftpd':   port => '21';
    }

    Selinux::Boolean {
        before      => Service[$vsftpd::params::service_name],
        persistent  => true,
    }

    selinux::boolean { $vsftpd::params::bool_allow_use_nfs:
        value       => $allow_use_nfs ? {
            true    => on,
            default => off,
        }
    }

    service { $vsftpd::params::service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
