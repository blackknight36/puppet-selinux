# modules/dart/manifests/abstract/workstation_node.pp

class dart::abstract::workstation_node inherits dart::abstract::base_node {
    include flock-herder
    # Lotus Notes has been disabled for now due to poor functioning.
    #include lotus_notes_client
    include packages::developer
    include packages::media
    include packages::net_tools
    include packages::virtualization
    include packages::workstation
    include unwanted-services
}
