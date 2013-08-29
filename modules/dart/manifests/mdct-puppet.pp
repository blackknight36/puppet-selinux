# modules/dart/manifests/mdct-puppet.pp
#
# Synopsis:
#       Puppet Master(s)
#
# Contact:
#       John Florian

class dart::mdct-puppet inherits dart::abstract::puppet_server_node {

    class { 'bacula::client':
        dir_passwd      => 'd730e38202fb2f6b8f8fb35045538a9f',
        mon_passwd      => 'db6696b5078c30697ae55a2788f0529d',
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
