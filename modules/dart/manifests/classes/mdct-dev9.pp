# modules/dart/manifests/classes/mdct-dev9.pp

class dart::mdct-dev9 inherits dart::workstation_node {
    include packages::kde
    include yum-cron
}