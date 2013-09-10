# modules/dart/manifests/mdct-est-ci.pp
#
# Synopsis:
#       TeamCity Continuous Integration server
#
# Contact:
#       Ben Minshall

class dart::mdct-est-ci inherits dart::abstract::teamcity_server_node {

    include 'dart::abstract::est_server_node'

    mailalias { 'root':
        ensure      => present,
        recipient   => 'ben.minshall@dart.biz',
    }

}
