# modules/dart/manifests/abstract/guarded_server_node.pp

class dart::abstract::guarded_server_node inherits dart::abstract::server_node {

    class { 'iptables':
        enabled => true,
    }

    class { 'selinux':
        # Note: most SEL mode changes require reboot to effect.
        mode    => 'enforcing',
    }

}
