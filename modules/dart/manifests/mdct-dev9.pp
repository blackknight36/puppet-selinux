# modules/dart/manifests/classes/mdct-dev9.pp

class dart::mdct-dev9 inherits dart::abstract::workstation_node {

    include jetbrains::idea
    include packages::kde
    include yum-cron

}
