# modules/dart/manifests/classes/mdct-f14-builder.pp

class dart::mdct-f14-builder inherits dart::abstract::build_server_node {
    include yum-cron
}
