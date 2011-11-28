# modules/dart/manifests/classes/mdct-dev14.pp

class dart::mdct-dev14 inherits dart::workstation_node {
    include packages::kde
    include yum-cron
}
