# modules/dart/manifests/mdct-f15-builder.pp

class dart::mdct-f15-builder inherits dart::abstract::build_server_node {
    include 'dart::subsys::yum_cron'
}
