# modules/dart/manifests/mdct-ci-agent1.pp
#
# Synopsis:
#       TeamCity build-farm member; with EST environment (for unit tests)
#
# Contact:
#       Ben Minshall
#
# TODO:
#       Rather than inheriting from dart::abstract::est_server_node, this
#       should probably inherit dart::abstract::server_node instead as it
#       likely only needs postgresql postgresql-server and postgresql-contrib
#       with an est user created in postgres, not tomcat and open ports in the
#       8000-range like the production EST system(s).
#
#       A good time to tackle such a change would be during the next rebuild
#       of this host, if ever.

class dart::mdct-ci-agent1 inherits dart::abstract::est_server_node {

    class { 'iptables':
        enabled => true,
    }

    lokkit::tcp_port { 'teamcity':
        port    => '9090',
    }

}
