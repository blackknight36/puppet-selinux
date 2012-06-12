# modules/dart/manifests/classes/mdct-dev11.pp

class dart::mdct-dev11 inherits dart::abstract::workstation_node {
    include packages::kde
    include yum-cron
}
