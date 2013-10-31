# modules/nfs/manifests/params.pp
#
# == Class: nfs::params
#
# Parameters for the nfs puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class nfs::params {

    case $::operatingsystem {
        Fedora: {

            if  $operatingsystemrelease == 'Rawhide' or
                $operatingsystemrelease >= 15
            {
                $utils_packages = [
                    'libnfsidmap',
                    'nfs-utils',
                ]
                $kernel_options = 'options nfs nfs4_disable_idmapping=n'
            } else {
                $utils_packages = [
                    'nfs-utils',
                    'nfs-utils-lib',
                ]
                $kernel_options = undef
            }

            if  $operatingsystemrelease == 'Rawhide' or
                $operatingsystemrelease >= 16
            {
                $idmap_service = 'nfs-idmap'
                $gss_service = 'nfs-secure'
            } elsif $operatingsystemrelease >= 15 {
                $idmap_service = 'rpcidmapd'
                $gss_service = 'rpcgssd'
            } else {
                $idmap_service = 'rpcidmapd'
                $gss_service = undef    # Sorry, no soup for you.  Upgrade!
            }

        }

        default: {
            fail ("The nfs module is not yet supported on ${::operatingsystem}.")
        }

    }

}
