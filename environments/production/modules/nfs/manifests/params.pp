# modules/nfs/manifests/params.pp
#
# == Class: nfs::params
#
# Parameters for the nfs puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>
#   Michael Watters <michael.watters@dart.biz>


class nfs::params {

    case $::operatingsystem {
        'Fedora': {

            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= '15'
            {
                $utils_packages = [
                    'libnfsidmap',
                    'nfs-utils',
                ]
                $kernel_options = 'options nfs nfs4_disable_idmapping=n callback_tcpport=4005'
            } else {
                $utils_packages = [
                    'nfs-utils',
                    'nfs-utils-lib',
                ]
                $kernel_options = undef
            }

            $bind_packages = 'rpcbind'
            $bind_service = 'rpcbind'

            # Which $gss_service?
            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= '16'
            {
                $gss_service = 'nfs-secure'
            } elsif $::operatingsystemrelease >= '15' {
                $gss_service = 'rpcgssd'
            } else {
                $gss_service = undef    # Sorry, no soup for you.  Upgrade!
            }

            # Which $idmap_service?
            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= '21'
            {
                $idmap_service = 'nfs-idmapd'
                # As of Fedora 21, the client uses a different mechanism.  See
                # nfsidmap(5) of the libnfsidmap package.  As such, these
                # clients no longer require a locally running ID mapper
                # daemon.  Additionally, the nfs-idmapd service became static
                # -- the ensure/enable states can/need not be managed.
                $idmap_service_is_static = true
            } elsif $::operatingsystemrelease >= '16' {
                $idmap_service = 'nfs-idmap'
                $idmap_service_is_static = false
            } else {
                $idmap_service = 'rpcidmapd'
                $idmap_service_is_static = false
            }

            # As of Fedora 21, the nfs-secure service became static -- the
            # ensure/enable states cannot be managed.  Instead, they're now
            # dependent on the existence of the /etc/krb5.keytab file.
            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= '21'
            {
                $gss_service_is_static = true
            } else {
                $gss_service_is_static = false
            }

            # Which $pipefs_service?
            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= '17'
            {
                $pipefs_service = 'var-lib-nfs-rpc_pipefs.mount'
            } else {
                $pipefs_service = undef
            }

            # set pipefs to be static on fedora 23+
            if $::operatingsystemrelease >= '23' {
                $pipefs_service_is_static = true
            } else {
                $pipefs_service_is_static = false
            }

            # Which $server_services?
            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= '20'
            {
                $server_services = 'nfs-server.service'
            } else {
                $server_services = 'nfs.target'
            }

        }

        'CentOS': {
            $utils_packages = [ 'libnfsidmap', 'nfs-utils', ]
            $kernel_options = 'options nfs nfs4_disable_idmapping=n callback_tcpport=4005'

            $bind_packages = 'rpcbind'
            $bind_service = 'rpcbind'

            $gss_service = 'rpcgssd'
            $gss_service_is_static = true

            $idmap_service = 'nfs-idmapd'
            $idmap_service_is_static = true

            $pipefs_service = undef
            $pipefs_service_is_static = false

            $server_services = 'nfs-server.service'
        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
