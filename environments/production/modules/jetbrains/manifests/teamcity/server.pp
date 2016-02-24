# modules/jetbrains/manifests/teamcity/server.pp
#
# == Class: jetbrains::teamcity::server
#
# Configures a host to run a JetBrains TeamCity Server.
#
# === Parameters
#
# NONE
#
# === Notes
#
#   1. Generally, you will want to just include the class
#   'jetbrains::teamcity::server::release' instead.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


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
    }

    iptables::tcp_port {
        'teamcity-server':  port => '8111';
    }

}
