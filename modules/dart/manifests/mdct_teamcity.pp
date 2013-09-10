# modules/dart/manifests/mdct_teamcity.pp
#
# Synopsis:
#       TeamCity Server
#
# Contact:
#       John Florian

class dart::mdct_teamcity inherits dart::abstract::teamcity_server_node {

    mailalias { 'root':
        ensure      => present,
        recipient   => 'john.florian@dart.biz',
    }

}
