# /etc/puppet/modules/dart/manifests/classes/mdct-f8-builder.pp

class dart::mdct-f8-builder inherits dart::build_server_node {
    include yum-cron
}
