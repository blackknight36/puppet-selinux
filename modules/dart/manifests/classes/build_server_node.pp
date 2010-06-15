# /etc/puppet/modules/dart/manifests/classes/build_server_node.pp

class dart::build_server_node inherits dart::server_node {
    include packages::developer
    include packages::net_tools
    include unwanted-services
}
