# /etc/puppet/modules/dart/manifests/classes/mdct-dev11.pp

class dart::mdct-dev11 inherits dart::workstation_node {
    include yum-cron
}
