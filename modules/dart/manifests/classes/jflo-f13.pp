# /etc/puppet/modules/dart/manifests/classes/jflo-f13.pp

class dart::jflo-f13 inherits dart::workstation_node {
    include yum-cron
}
