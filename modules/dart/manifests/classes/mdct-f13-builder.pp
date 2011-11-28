# modules/dart/manifests/classes/mdct-f13-builder.pp

class dart::mdct-f13-builder inherits dart::build_server_node {
    include yum-cron
}
