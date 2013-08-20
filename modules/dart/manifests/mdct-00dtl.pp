# modules/dart/manifests/mdct-00dtl.pp
#
# Synopsis:
#       TestLink server for development
#
# Contact:
#       Nathan Nephew

class dart::mdct-00dtl inherits dart::abstract::server_node {

    class { 'iptables':
        enabled => true,
    }

    class { 'puppet::client':
    }

}
