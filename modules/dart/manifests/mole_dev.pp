# modules/dart/manifests/mole-dev.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Brian Moles

class dart::mole_dev inherits dart::abstract::guarded_server_node {

    class { 'puppet::client':
    }

}