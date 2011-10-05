# /etc/puppet/modules/rsync-server/manifests/init.pp

class rsync-server {

    include lokkit
    include xinetd

    package { "rsync":
	ensure	=> installed,
    }

    file { "/etc/xinetd.d/rsync":
        group	=> "root",
        mode    => 644,
        notify  => Service["xinetd"],
        owner   => "root",
        require => Package["rsync"],
        source  => "puppet:///rsync-server/rsync",
    }

    lokkit::tcp_port { "rsync":
        port    => "873",
    }

}
