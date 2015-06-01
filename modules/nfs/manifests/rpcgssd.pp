# modules/nfs/manifests/rpcgssd.pp
#
# == Class: nfs::rpcgssd
#
# Configures a host to run the RPCSEC_GSS (per RFC 5403) daemon.
#
# === Parameters
#
# [*enable*]
#   If true, enable the General Security Services (GSS) for user
#   authentication.  The default is true.  Depending on the OS release, it
#   may not be possible to disable GSS for NFS.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>


class nfs::rpcgssd (
        $enable=true,
    ) {

    include 'nfs::params'
    include 'nfs::utils'

    if $nfs::params::gss_service == undef {
        warning "nfs::rpcgssd is not supported on ${::fqdn} running ${::operatingsystem} ${::operatingsystemrelease}."
    } else {

        # Managing the ensure and enable states for a static service is
        # ineffectual and generates lots of useless reporting.
        $__enable = $nfs::params::gss_service_is_static ? {
            true    => undef,
            default => $enable,
        }

        service { $nfs::params::gss_service:
            ensure     => $__enable,
            enable     => $__enable,
            hasrestart => true,
            hasstatus  => true,
        }

    }

}
