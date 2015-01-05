# modules/nfs/manifests/rpcgssd.pp
#
# == Class: nfs::rpcgssd
#
# Configures a host to run the NFS ID Mapper daemon.
#
# === Parameters
#
# [*enable*]
#   If true, enable the General Security Services (GSS) for user
#   authentication.  The default is true.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class nfs::rpcgssd (
        $enable=true,
    ) {

    include 'nfs::params'
    include 'nfs::utils'

    if $nfs::params::gss_service == undef {
        warning "nfs::rpcgssd is not supported on ${::fqdn} running ${::operatingsystem} ${::operatingsystemrelease}."
    } else {

        service { $nfs::params::gss_service:
            ensure      => $enable,
            enable      => $enable,
            hasrestart  => true,
            hasstatus   => true,
        }

    }

}
