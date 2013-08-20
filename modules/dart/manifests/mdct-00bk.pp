# modules/dart/manifests/mdct-00bk.pp
#
# Synopsis:
#       Bacula backup system (director & storage daemons)
#
# Contact:
#       John Florian

class dart::mdct-00bk inherits dart::abstract::server_node {

    class { 'puppet::client':
    }

}
