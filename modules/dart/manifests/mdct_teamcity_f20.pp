# modules/dart/manifests/mdct_teamcity_f20.pp
#
# == Class: dart::mdct_teamcity_f20
#
# Configures a host as our TeamCity Server with a Build Agent
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


class dart::mdct_teamcity_f20 inherits dart::abstract::teamcity_server_node {

    # Most TeamCity Servers also feature a bundled Agent, so we do too,
    # though our Puppet infrastructure doesn't require it.
    include 'dart::abstract::teamcity_agent_node'

    sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

    include 'repoview'

    package { 'createrepo':
        ensure  => installed,
    }

    class { 'bacula::client':
        dir_name    => 'mdct-bacula-dir',
        dir_passwd  => 'RFdZ9Dm9bxuIEIp1Q7Gu0sEoHX9AUHecFbwE6weT1IAz',
        mon_name    => 'mdct-bacula-mon',
        mon_passwd  => 'hRGbzxczzByoo9chMe7y6Qlxeo0dmfedAKJCP9Y2M4o6',
    }

}
