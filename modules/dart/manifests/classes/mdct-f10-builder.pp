# /etc/puppet/modules/dart/manifests/classes/mdct-f10-builder.pp

class dart::mdct-f10-builder inherits dart::build_server_node {
    include yum-cron
}
