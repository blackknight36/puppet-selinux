# modules/dart/manifests/mdct-dev7.pp

class dart::mdct-dev7 inherits dart::abstract::workstation_node {
    include 'dart::subsys::yum_cron'
}
