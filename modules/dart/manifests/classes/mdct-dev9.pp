# /etc/puppet/modules/dart/manifests/classes/mdct-dev9.pp

class dart::mdct-dev9 inherits dart::workstation_node {
    include yum-cron

    mailalias { "root":
        ensure          => present,
        recipient       => "mark_king@dart.biz",
    }

}
