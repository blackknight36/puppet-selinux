# modules/dart/manifests/mdct_est_ci.pp
#
# Synopsis:
#       TeamCity Continuous Integration server
#
# Contact:
#       Ben Minshall

class dart::mdct_est_ci inherits dart::abstract::teamcity_server_node {

    include 'dart::abstract::est_server_node'

    # Most TeamCity Servers also feature a bundled Agent, so we do too,
    # though our Puppet infrastructure doesn't require it.
    include 'dart::abstract::teamcity_agent_node'


    sendmail::alias { 'root':
        recipient   => 'ben.minshall@dart.biz',
    }

}
