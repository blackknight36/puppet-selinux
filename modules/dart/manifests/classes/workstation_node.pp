# /etc/puppet/modules/dart/manifests/classes/workstation_node.pp

class dart::workstation_node inherits dart::base_node {
    include lotus_notes_client
    include packages::developer
    include packages::media
    include packages::net_tools
    include packages::virtualization
    include packages::workstation
    include unwanted-services
}
