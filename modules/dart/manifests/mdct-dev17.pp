# modules/dart/manifests/mdct-dev17.pp

class dart::mdct-dev17 inherits dart::abstract::workstation_node {

    include 'dart::subsys::yum_cron'
    include 'jetbrains::idea'

}
