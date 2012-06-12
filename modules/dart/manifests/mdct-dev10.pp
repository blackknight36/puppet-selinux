# modules/dart/manifests/mdct-dev10.pp

class dart::mdct-dev10 inherits dart::abstract::workstation_node {

    include jetbrains::idea
    include yum-cron

}
