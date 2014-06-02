# modules/dart/manifests/mdct_puppet.pp
#
# Synopsis:
#       Puppet Master(s)
#
# Contact:
#       John Florian

class dart::mdct_puppet inherits dart::abstract::puppet_server_node {

    class { 'bacula::client':
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => 'WnB1NCb0T5WEcac5OtHdX47fi7vFreLMicbbt9jsizuC',
        mon_name    => $dart::params::bacula_mon_name,
        mon_passwd  => 'QGnCsKgAgta41AUGHiKVOveXHUJaphdQwyRQYH2ox0xt',
    }

    iptables::rules_file { 'blocks':
        source  => 'puppet:///private-host/iptables/blocks',
    }

    file { '/etc/motd':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => 'puppet:///private-host/motd',
    }

}
