# /etc/puppet/modules/dart/manifests/classes/mdct-dev7.pp

class dart::mdct-dev7 inherits dart::base_node {
    include packages::workstation
}
