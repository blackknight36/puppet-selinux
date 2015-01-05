# modules/nfs/manifests/client.pp
#
# == Class: nfs::client
#
# Manages the NFS client services on a host.
#
# === Parameters
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
    ) {

    include 'nfs::params'

    class { 'nfs::rpcidmapd':
        domain  => $domain,
    }

    class { 'nfs::rpcgssd':
        enable  => $use_gss,
    }

}
