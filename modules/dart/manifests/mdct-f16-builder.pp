# modules/dart/manifests/classes/mdct-f16-builder.pp

class dart::mdct-f16-builder inherits dart::abstract::build_server_node {
    include yum-cron
}