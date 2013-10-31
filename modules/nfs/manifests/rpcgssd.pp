# modules/nfs/manifests/rpcgssd.pp
#
# == Class: nfs::rpcgssd
#
# Configures a host to run the NFS ID Mapper daemon.
#
# === Parameters
#
# None
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class nfs::rpcgssd {

    # Stage => early

    include 'nfs::params'
    include 'nfs::utils'

    if $nfs::params::gss_service == undef {
        warning "nfs::rpcgssd is not supported on $operatingsystem $operatingsystemrelease"
    } else {

        service { $nfs::params::gss_service:
            enable      => true,
            ensure      => running,
            hasrestart  => true,
            hasstatus   => true,
        }

    }

}
