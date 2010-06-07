# /etc/puppet/modules/dart/manifests/classes/workstation_node.pp

class dart::workstation_node inherits dart::base_node {
    include lotus_notes_client
    include pkgs_developer
    include pkgs_media
    include pkgs_net_tools
    include pkgs_virtualization
    include pkgs_workstation
    include unwanted-services
}
