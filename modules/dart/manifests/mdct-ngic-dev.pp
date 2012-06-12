# modules/dart/manifests/classes/mdct-ngic-dev.pp

class dart::mdct-ngic-dev inherits dart::abstract::ngic_server_node {

    class { 'iptables':
        enabled => true,
    }

	lokkit::tcp_port {
		'postgresql':		port => '5432';
	}

}
