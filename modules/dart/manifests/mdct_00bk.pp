# modules/dart/manifests/mdct-00bk.pp
#
# Synopsis:
#       Bacula backup system (director & storage daemons)
#
# Contact:
#       John Florian

class dart::mdct_00bk inherits dart::abstract::guarded_server_node {

    class { 'puppet::client':
    }

}
