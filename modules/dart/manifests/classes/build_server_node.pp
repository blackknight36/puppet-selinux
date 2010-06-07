# /etc/puppet/modules/dart/manifests/classes/build_server_node.pp

class dart::build_server_node inherits dart::server_node {
    include pkgs_developer
    include pkgs_net_tools
    include unwanted-services
}
