# modules/dart/manifests/mdct-dev16.pp

class dart::mdct-dev16 inherits dart::abstract::workstation_node {

    include jetbrains::idea
    include packages::kde
    include yum-cron

    lokkit::tcp_port {
        'gwt-codeserver':       port => '9997';
        'gwt-debug':            port => '8888';
        'http':                 port => '80';
        'postgres':             port => '5432';
        'teamcity-build-agent': port => '9090';
    }

}
