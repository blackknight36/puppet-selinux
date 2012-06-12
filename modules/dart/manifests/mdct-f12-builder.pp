# modules/dart/manifests/mdct-f12-builder.pp

class dart::mdct-f12-builder inherits dart::abstract::build_server_node {
    include yum-cron
}
