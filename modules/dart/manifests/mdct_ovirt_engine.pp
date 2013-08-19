# modules/dart/manifests/mdct-ovirt-engine.pp

class dart::mdct_ovirt_engine inherits dart::abstract::server_node {

    include 'dart::subsys::yum::ovirt'

    class { 'puppet::client':
    }

}
