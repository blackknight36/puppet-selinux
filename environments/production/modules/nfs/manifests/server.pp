# modules/nfs/manifests/server.pp
#
# == Class: nfs::server
#
# Manages a host as a NFS server.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*enabled*]
#   If true (default), the instance will be enabled.
#
# [*exports_content*]
#   Content of the NFS server "exports" file content.  If neither
#   "exports_content" nor "exports_source" is given, the content of the file
#   will be left unmanaged.
#
# [*exports_source*]
#   URI of the NFS server "exports" file content.  If neither
#   "exports_content" nor "exports_source" is given, the content of the file
#   will be left unmanaged.
#
# [*manage_firewall*]
#   If true, open the NFS ports on the firewall.  Otherwise the firewall is
#   left unaffected.  Defaults to true.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class nfs::server (
        $enabled=true,
        $exports_content=undef,
        $exports_source=undef,
        $manage_firewall=true,
    ) inherits ::nfs::params {

    class { '::nfs::rpcbind':
        manage_firewall => $manage_firewall,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'exports_t',
        before      => Service[$::nfs::params::server_services],
        notify      => Service[$::nfs::params::server_services],
    }

    if $enabled {
        file { '/etc/exports':
            content => $exports_content,
            source  => $exports_source,
        }
        $ensure = 'running'
    } else {
        $ensure = 'stopped'
    }

    if $manage_firewall {
        ::iptables::tcp_port { '550 accept NFS packets':
            port => '2049',
        }
    }

    service { $::nfs::params::server_services:
        ensure     => $ensure,
        enable     => $enabled,
        hasrestart => true,
        hasstatus  => true,
        provider   => 'systemd',
    }

}
