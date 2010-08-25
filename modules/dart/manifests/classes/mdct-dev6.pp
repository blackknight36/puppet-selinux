# /etc/puppet/modules/dart/manifests/classes/mdct-dev6.pp

class dart::mdct-dev6 inherits dart::workstation_node {
    include packages::kde

    mailalias { "root":
        ensure          => present,
        recipient       => "chris.kennedy@dart.biz",
    }

}
