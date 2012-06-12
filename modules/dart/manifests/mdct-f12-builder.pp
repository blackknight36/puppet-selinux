# modules/dart/manifests/classes/mdct-f12-builder.pp

class dart::mdct-f12-builder inherits dart::build_server_node {
    include yum-cron
}
