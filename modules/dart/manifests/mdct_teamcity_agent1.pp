# modules/dart/manifests/mdct_teamcity_agent1.pp
#
# Synopsis:
#       TeamCity Build Agent
#
# Contact:
#       John Florian

class dart::mdct_teamcity_agent1 inherits dart::abstract::teamcity_agent_node {

    sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

}
