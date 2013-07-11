# modules/dart/manifests/mdct-f19-builder.pp

class dart::mdct-f19-builder inherits dart::abstract::build_server_node {
    include 'yum-cron'
}
