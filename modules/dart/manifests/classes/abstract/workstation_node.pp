# modules/dart/manifests/classes/workstation_node.pp

class dart::abstract::workstation_node inherits dart::abstract::base_node {
    include flock-herder
    include lotus_notes_client
    include packages::developer
    include packages::media
    include packages::net_tools
    include packages::virtualization
    include packages::workstation
    include unwanted-services
}
