# modules/dart/manifests/classes/mdct-puppet.pp

class dart::mdct-puppet inherits dart::abstract::puppet_server_node {
    # passwords generated with bacula-password-generator package
    $bacula_client_director_password = "d730e38202fb2f6b8f8fb35045538a9f"
    $bacula_client_director_monitor_password = "db6696b5078c30697ae55a2788f0529d"
    include bacula::client

    class { 'iptables':
        enabled => true,
    }

    lokkit::rules_file { 'blocks':
        source  => 'puppet:///private-host/lokkit/blocks',
    }

}
