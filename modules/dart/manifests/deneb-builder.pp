# modules/dart/manifests/deneb-builder.pp

class dart::deneb-builder inherits dart::abstract::build_server_node {
    include yum-cron
}
