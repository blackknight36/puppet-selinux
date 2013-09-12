# modules/dart/manifests/abstract/teamcity_agent_node.pp
#
# Synopsis:
#       Typical TeamCity Agent for Dart use.


class dart::abstract::teamcity_agent_node inherits dart::abstract::guarded_server_node {

    include 'autofs'
    include 'dart::subsys::yum_cron'

    oracle::jdk { 'for TeamCity Agent':
        ensure  => 'latest',
        # Oracle's architecture labeling is non-standard; so we adapt here.
        arch    => $architecture ? {
            'i386'      => 'i586',
            'x86_64'    => 'x64',
        },
    }

    include 'packages::developer'
    include 'puppet::client'

    iptables::tcp_port {
        'teamcity': port => '9090';
    }

    case $hostname {
#       'mdct-est-ci': {
#           jetbrains::teamcity::agent_release { 'TeamCity-7.1':
#               build   => '7.1',
#           }
#       }
        'mdct-teamcity', 'mdct-teamcity-agent1': {
            jetbrains::teamcity::agent_release { 'TeamCity-8.0.3':
                build   => '8.0.3',
            }
        }
    }

}
