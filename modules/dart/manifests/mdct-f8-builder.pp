# modules/dart/manifests/mdct-f8-builder.pp

class dart::mdct-f8-builder inherits dart::abstract::build_server_node {
    include yum-cron
}
