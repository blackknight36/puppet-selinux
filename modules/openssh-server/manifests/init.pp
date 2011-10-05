# /etc/puppet/modules/openssh-server/manifests/init.pp

class openssh-server {

    include lokkit

    package { "openssh-server":
	ensure	=> installed,
    }

    file { "/etc/ssh/sshd_config":
        group	=> "root",
        mode    => 600,
        owner   => "root",
        require => Package["openssh-server"],
	source	=> [
            "puppet:///openssh-server/sshd_config.$hostname",
            "puppet:///openssh-server/sshd_config.$operatingsystem.$operatingsystemrelease",
            "puppet:///openssh-server/sshd_config",
        ],
    }

    lokkit::tcp_port { "ssh":
        port    => "22",
    }

    service { "sshd":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-ssh-tcp-port"],
            Package["openssh-server"],
        ],
        subscribe	=> [
            File["/etc/ssh/sshd_config"],
        ]
    }

}
