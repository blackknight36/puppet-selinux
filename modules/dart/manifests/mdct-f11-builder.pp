# modules/dart/manifests/mdct-f11-builder.pp

class dart::mdct-f11-builder inherits dart::abstract::build_server_node {
    include yum-cron
}
