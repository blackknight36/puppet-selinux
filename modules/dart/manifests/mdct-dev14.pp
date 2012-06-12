# modules/dart/manifests/mdct-dev14.pp

class dart::mdct-dev14 inherits dart::abstract::workstation_node {
    include packages::kde
    include yum-cron
}
