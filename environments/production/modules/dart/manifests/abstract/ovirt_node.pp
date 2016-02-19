# modules/dart/manifests/abstract/ovirt_node.pp

class dart::abstract::ovirt_node inherits dart::abstract::server_node {

    class { 'iptables':
        managed_host    => false,
    }

}
