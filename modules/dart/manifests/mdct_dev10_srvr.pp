# modules/dart/manifests/mdct-dev10-srvr.pp
#
# Synopsis:
#       Experimental VM-based servers
#
# Contact:
#       Levi Harper

class dart::mdct_dev10_srvr inherits dart::abstract::guarded_server_node {

    class { 'puppet::client':
    }

}
