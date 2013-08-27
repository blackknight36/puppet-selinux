# ./modules/dart/manifests/abstract/semi_guarded_server_node.pp

class dart::abstract::semi_guarded_server_node inherits dart::abstract::server_node {

    class { 'iptables':
        enabled => true,
    }

    class { 'selinux':
        # Note: most SEL mode changes require reboot to effect.
        mode    => 'disabled',
    }

}
