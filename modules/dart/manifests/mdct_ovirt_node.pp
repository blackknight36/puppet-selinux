# modules/dart/manifests/mdct_ovirt_node.pp

class dart::mdct_ovirt_node inherits dart::abstract::server_node {

    include 'dart::subsys::yum::fedora_virt_preview'

    class { 'puppet::client':
    }

}
