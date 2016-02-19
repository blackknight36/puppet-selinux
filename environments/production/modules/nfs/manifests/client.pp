# modules/nfs/manifests/client.pp
#
# == Class: nfs::client
#
# Manages the NFS client services on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*domain*]
#   Name of the NFS domain.  Defaults to the "domain" fact.
#
# [*use_gss*]
#   If true, enable the General Security Services (GSS) for user
#   authentication.  The default is true.  Depending on the OS release, it
#   may not be possible to disable GSS for NFS.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class nfs::client (
        $domain=$::domain,
        $use_gss=true,
    ) inherits ::nfs::params {

    # NB: The client also requires rpcbind (formerly known as the portmapper),
    # but only for NFSv3 and earlier.  NFSv4 does not use rpcbind at all.  We
    # shouldn't need to manage rpcbind here because nfs-utils ships the
    # service as static and starts it running automatically via the
    # rpcbind.socket unit, but only if needed (for v3 or earlier).
    #
    # However, F21 hosts built as of late by puppet don't seem to have
    # a usable NFSv3 client.  It seems necessary to "systemctl enable
    # rpcbind.service" on these.  That has been done manually for a few until
    # a proper solution can be achieved.

    # Managing the ensure and enable states for a static service is
    # ineffectual and generates lots of useless reporting.
    $idmap_ensure = $::nfs::params::idmap_service_is_static ? {
        true    => 'stopped',
        default => true,
    }
    $idmap_enable = $::nfs::params::idmap_service_is_static ? {
        true    => undef,
        default => true,
    }

    class { '::nfs::rpcidmapd':
        ensure => $idmap_ensure,
        enable => $idmap_enable,
        domain => $domain,
    }

    class { '::nfs::rpcgssd':
        enable => $use_gss,
    }

}
