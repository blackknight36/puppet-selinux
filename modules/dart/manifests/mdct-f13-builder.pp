# modules/dart/manifests/mdct-f13-builder.pp

class dart::mdct-f13-builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}
