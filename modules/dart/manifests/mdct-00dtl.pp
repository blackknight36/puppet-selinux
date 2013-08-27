# modules/dart/manifests/mdct-00dtl.pp
#
# Synopsis:
#       TestLink server for development
#
# Contact:
#       Nathan Nephew

class dart::mdct-00dtl inherits dart::abstract::semi_guarded_server_node {

    class { 'puppet::client':
    }

}
