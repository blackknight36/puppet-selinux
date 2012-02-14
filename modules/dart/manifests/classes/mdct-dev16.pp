# modules/dart/manifests/classes/mdct-dev16.pp

class dart::mdct-dev16 inherits dart::workstation_node {
    include packages::kde
    include yum-cron

    lokkit::tcp_port { 'postgres':
        port    => '5432',
    }

}
