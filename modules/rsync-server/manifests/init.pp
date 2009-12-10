# /etc/puppet/modules/rsync-server/manifests/init.pp

class rsync-server {

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

    exec { "open-rsync-port":
        command => "lokkit --port=873:tcp --port:873:udp",
        require		=> [
            Package["rsync"],
        ],
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 873 -j ACCEPT' /etc/sysconfig/iptables",
    }

}
