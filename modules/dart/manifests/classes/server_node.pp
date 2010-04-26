# /etc/puppet/modules/dart/manifests/classes/server_node.pp

class dart::server_node inherits dart::base_node {
    include pkgs_net_tools
}
