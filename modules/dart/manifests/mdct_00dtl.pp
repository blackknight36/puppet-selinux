# modules/dart/manifests/mdct_00dtl.pp
#
# Synopsis:
#       TestLink server for development
#
# Contact:
#       Nathan Nephew

class dart::mdct_00dtl inherits dart::abstract::semi_guarded_server_node {

    class { 'puppet::client':
    }

}
