# modules/jetbrains/manifests/teamcity/agent.pp
#
# Synopsis:
#       Configures a host to run a JetBrains TeamCity Build Agent.
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
#       'jetbrains::teamcity::agent_release' instead.


class jetbrains::teamcity::agent {

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
        'teamcity-agent':   port => '9090';
    }

}
