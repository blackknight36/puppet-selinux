# modules/dart/manifests/classes/mdct-f11-builder.pp

class dart::mdct-f11-builder inherits dart::build_server_node {
    include yum-cron
}
