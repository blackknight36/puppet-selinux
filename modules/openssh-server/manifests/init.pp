# /etc/puppet/modules/openssh-server/manifests/init.pp

class openssh-server {

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

    exec { "open-sshd-port":
        command => "lokkit --port=22:tcp",
	# Fedora 8 will have chains named like RH-Firewall-1-INPUT.  In later
	# releases, the chain is named simply INPUT.
        unless  => "grep -q -- '-A .*INPUT .* -p tcp --dport 22 -j ACCEPT' /etc/sysconfig/iptables",
    }

    service { "sshd":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-sshd-port"],
            Package["openssh-server"],
        ],
        subscribe	=> [
            File["/etc/ssh/sshd_config"],
        ]
    }

}
