# modules/dart/manifests/mdct_teamcity_agent.pp
#
# == Class: dart::mdct_teamcity_agent
#
# Configures a host as a TeamCity agent for Dart.
#
# === Parameters
#
# NONE
#
# === Contact
#
#   John Florian <john.florian@dart.biz>
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_teamcity_agent inherits dart::abstract::teamcity_agent_node {

    sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

}
