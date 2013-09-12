# modules/dart/manifests/mdct_teamcity.pp
#
# Synopsis:
#       TeamCity Server
#
# Contact:
#       John Florian

class dart::mdct_teamcity inherits dart::abstract::teamcity_server_node {

    # Most TeamCity Servers also feature a bundled Agent, so we do too,
    # though our Puppet infrastructure doesn't require it.
    include 'dart::abstract::teamcity_agent_node'

    mailalias { 'root':
        ensure      => present,
        recipient   => 'john.florian@dart.biz',
    }

}
