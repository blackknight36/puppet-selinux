# modules/dart/manifests/mdct-f18-builder.pp

class dart::mdct-f18-builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}
