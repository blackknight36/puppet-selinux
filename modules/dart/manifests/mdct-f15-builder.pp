# modules/dart/manifests/classes/mdct-f15-builder.pp

class dart::mdct-f15-builder inherits dart::build_server_node {
    include yum-cron
}
