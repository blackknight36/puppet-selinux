# /etc/puppet/modules/dart/manifests/classes/mdct-f14-builder.pp

class dart::mdct-f14-builder inherits dart::build_server_node {
    include yum-cron
}
