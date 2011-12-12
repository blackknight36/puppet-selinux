# modules/dart/manifests/classes/server_node.pp

class dart::server_node inherits dart::base_node {
    include packages::net_tools

    # Servers especially benefit from showing their boot details.
    $plymouth_default_theme = "details"
    include plymouth
}
