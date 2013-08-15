# modules/dart/manifests/mdct_ovirt_node.pp

class dart::mdct_ovirt_node inherits dart::abstract::server_node {

    class { 'puppet::client':
    }

}
