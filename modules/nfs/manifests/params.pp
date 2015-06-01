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


class nfs::params {

    case $::operatingsystem {
        Fedora: {

            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= 15
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

            # Which $gss_service?
            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= 16
            {
                $gss_service = 'nfs-secure'
            } elsif $::operatingsystemrelease >= 15 {
                $gss_service = 'rpcgssd'
            } else {
                $gss_service = undef    # Sorry, no soup for you.  Upgrade!
            }

            # Which $idmap_service?
            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= 21
            {
                $idmap_service = 'nfs-idmapd'
            } elsif $::operatingsystemrelease >= 16 {
                $idmap_service = 'nfs-idmap'
            } else {
                $idmap_service = 'rpcidmapd'
            }

            # As of Fedora 21, the nfs-secure service became static -- the
            # ensure/enable states cannot be managed.  Instead, they're now
            # dependent on the existence of the /etc/krb5.keytab file.
            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= 21
            {
                $gss_service_is_static = true
            } else {
                $gss_service_is_static = false
            }

            # Which $pipefs_service?
            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= 17
            {
                $pipefs_service = 'var-lib-nfs-rpc_pipefs.mount'
            } else {
                $pipefs_service = undef
            }

            # Which $server_services?
            if  $::operatingsystemrelease == 'Rawhide' or
                $::operatingsystemrelease >= 20
            {
                $server_services = 'nfs-server.service'
            } else {
                $server_services = 'nfs.target'
            }

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
