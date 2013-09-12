# modules/jetbrains/manifests/teamcity/server.pp
#
# Synopsis:
#       Configures a host to run a JetBrains TeamCity Server.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       NONE
#
# Requires:
#       NONE
#
# Notes:
#       - Generally, you will want to just include the class
#       'jetbrains::teamcity::server_release' instead.


class jetbrains::teamcity::server {

    include 'jetbrains'
    include 'jetbrains::params'
    include 'jetbrains::teamcity::common'

    File {
        owner   => 'teamcity',
        group   => 'teamcity',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        require => User['teamcity'],
    }

    iptables::tcp_port {
        'teamcity-server':  port => '8111';
    }

}
