# modules/dart/manifests/classes/mdct-ngic-dev.pp

class dart::mdct-dr-dev inherits dart::abstract::dr_server_node {

    class { 'iptables':
        enabled => true,
    }

	lokkit::tcp_port {
		'postgresql':		port => '5432';
	}

}