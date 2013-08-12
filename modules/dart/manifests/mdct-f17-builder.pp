# modules/dart/manifests/mdct-f17-builder.pp

class dart::mdct-f17-builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}
