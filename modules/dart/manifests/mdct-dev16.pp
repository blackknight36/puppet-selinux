# modules/dart/manifests/mdct-dev16.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Ben Minshall

class dart::mdct-dev16 inherits dart::abstract::workstation_node {

    include jetbrains::idea
    include packages::kde
    include 'dart::subsys::yum_cron'

    iptables::tcp_port {
        'gwt-codeserver':       port => '9997';
        'gwt-debug':            port => '8888';
        'http':                 port => '80';
        'postgres':             port => '5432';

        # This class may want to include dart::abstract::teamcity_agent_node.
        'teamcity-build-agent': port => '9090';
    }

}
