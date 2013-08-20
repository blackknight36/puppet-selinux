# modules/dart/manifests/mdct_ovirt_node.pp
#
# Synopsis:
#       oVirt Nodes (host team VMs)
#
# Contact:
#       Levi Harper

class dart::mdct_ovirt_node inherits dart::abstract::server_node {

    include 'dart::subsys::yum::fedora_virt_preview'

    class { 'puppet::client':
    }

    include 'tsocks'

}
