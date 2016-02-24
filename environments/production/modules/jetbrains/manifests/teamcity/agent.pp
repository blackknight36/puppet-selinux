# modules/jetbrains/manifests/teamcity/agent.pp
#
# == Class: jetbrains::teamcity::agent
#
# Configures a host to run a JetBrains TeamCity Build Agent.
#
# === Parameters
#
# NONE
#
# === Notes
#
#   1. Generally, you will want to just include the class
#   'jetbrains::teamcity::agent::release' instead.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


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
    }

    iptables::tcp_port {
        'teamcity-agent':   port => '9090';
    }

}
