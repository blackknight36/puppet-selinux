# /etc/puppet/modules/dart/manifests/classes/mdct-dev10.pp

class dart::mdct-dev10 inherits dart::workstation_node {
    include yum-cron
}
