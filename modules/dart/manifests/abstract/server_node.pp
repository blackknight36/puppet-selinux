# modules/dart/manifests/abstract/server_node.pp

class dart::abstract::server_node inherits dart::abstract::base_node {
    include packages::net_tools

    # Servers especially benefit from showing their boot details.
    class { 'plymouth':
        theme   => 'details',
    }

}
