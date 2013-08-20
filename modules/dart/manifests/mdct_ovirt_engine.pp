# modules/dart/manifests/mdct-ovirt-engine.pp
#
# Synopsis:
#       oVirt Engine (manages oVirt nodes, which host team VMs)
#
# Contact:
#       Levi Harper

class dart::mdct_ovirt_engine inherits dart::abstract::server_node {

    include 'dart::subsys::yum::ovirt'

    class { 'puppet::client':
    }

}
