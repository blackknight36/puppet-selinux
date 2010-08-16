# /etc/puppet/modules/logwatch/manifests/init.pp

class logwatch {

    package { "logwatch":
	ensure	=> installed,
    }

}
