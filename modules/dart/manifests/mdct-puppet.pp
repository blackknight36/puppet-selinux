# modules/dart/manifests/mdct-puppet.pp

class dart::mdct-puppet inherits dart::abstract::puppet_server_node {

    class { 'bacula::client':
        dir_passwd      => 'd730e38202fb2f6b8f8fb35045538a9f',
        mon_passwd      => 'db6696b5078c30697ae55a2788f0529d',
    }

    class { 'iptables':
        enabled => true,
    }

    lokkit::rules_file { 'blocks':
        source  => 'puppet:///private-host/lokkit/blocks',
    }

}
