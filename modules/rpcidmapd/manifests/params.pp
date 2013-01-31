# modules/rpcidmapd/manifests/params.pp
#
# Synopsis:
#       Parameters for the rpcidmapd puppet module.


class rpcidmapd::params {

    case $::operatingsystem {
        Fedora: {

            if  $operatingsystemrelease == 'Rawhide' or
                $operatingsystemrelease >= 15
            {
                $packages = [
                    'libnfsidmap',
                    'nfs-utils',
                ]
                $kernel_options = 'options nfs nfs4_disable_idmapping=n'
            } else {
                $packages = [
                    'nfs-utils',
                    'nfs-utils-lib',
                ]
                $kernel_options = undef
            }

            if  $operatingsystemrelease == 'Rawhide' or
                $operatingsystemrelease >= 16
            {
                $service_name = 'nfs-idmap'
            } else {
                $service_name = 'rpcidmapd'
            }

        }

        default: {
            fail ("The rpcidmapd module is not yet supported on ${operatingsystem}.")
        }

    }

}
