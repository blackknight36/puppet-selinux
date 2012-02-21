# modules/dart/manifests/classes/mdct-dev16.pp

class dart::mdct-dev16 inherits dart::workstation_node {

    include packages::kde
    include yum-cron

    lokkit::tcp_port { 'gwt-codeserver':
        port    => '9997',
    }

    lokkit::tcp_port { 'gwt-debug':
        port    => '8888',
    }

    lokkit::tcp_port { 'postgres':
        port    => '5432',
    }

}
