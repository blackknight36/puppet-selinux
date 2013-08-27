# modules/dart/manifests/mdct-00dw.pp
#
# Synopsis:
#       EST data warehouse
#
# Contact:
#       Ben Minshall

class dart::mdct-00dw inherits dart::abstract::guarded_server_node {

    class { 'puppet::client':
    }

}
