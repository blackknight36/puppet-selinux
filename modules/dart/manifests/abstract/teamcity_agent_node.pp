# modules/dart/manifests/abstract/teamcity_agent_node.pp
#
# == Class: dart::abstract::teamcity_agent_node
#
# Configures a host as a typical TeamCity Agent for Dart use.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::abstract::teamcity_agent_node inherits dart::abstract::guarded_server_node {

    include '::dart::abstract::packages::developer'
    include '::dart::abstract::teamcity_agent_node_est_ngic'
    include '::dart::subsys::autofs::common'
    include '::dart::subsys::mock'
    include '::dart::subsys::yum_cron'
    include '::lyx'
    include '::puppet::client'

    case $::hostname {
        'mdct-est-ci': {
            ::jetbrains::teamcity::agent::release { 'TeamCity-7.1':
                build   => '7.1',
            }
        }
        /^mdct-teamcity-agent.*$/: {
            include '::openjdk::java_1_7_0'

            ::jetbrains::teamcity::agent::release { 'TeamCity-9.0.1':
                build      => '9.0.1',
                server_url => 'http://mdct-teamcity-f20.dartcontainer.com:8111/',
            }

            ::jetbrains::teamcity::agent::release { 'TeamCity-8.1.4':
                ensure     => absent,
                build      => '8.1.4',
                server_url => 'http://mdct-teamcity-f20.dartcontainer.com:8111/',
            }

        }
        default: {
            fail('Missing host-specific details!')
        }
    }

}
