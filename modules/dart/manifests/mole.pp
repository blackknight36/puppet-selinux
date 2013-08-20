# modules/dart/manifests/mole.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Brian Moles

class dart::mole inherits dart::abstract::workstation_node {

    include postgresql::server

}
