# modules/dart/manifests/abstract/unguarded_server_node.pp

class dart::abstract::unguarded_server_node inherits dart::abstract::server_node {

    class { 'iptables':
        enabled => false,
    }

    class { 'selinux':
        # Note: most SEL mode changes require reboot to effect.
        mode    => 'disabled',
    }

}
