# /etc/puppet/modules/dart/manifests/classes/puppet_server_node.pp

class dart::puppet_server_node inherits dart::server_node {
    include packages::developer
    include puppet-server
    include yum-cron
}
