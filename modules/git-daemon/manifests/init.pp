# modules/git-daemon/manifests/init.pp

class git-daemon {

    include lokkit

    package { "git-daemon":
	ensure	=> installed,
    }

    file { "/etc/xinetd.d/git":
        group	=> "root",
        mode    => "0644",
        owner   => "root",
        require => Package["git-daemon"],
        seluser => "system_u",
        selrole => "object_r",
        seltype => "etc_t",
        source  => [
            "puppet:///private-host/git-daemon/xinetd-git.conf",
            "puppet:///modules/git-daemon/xinetd-git.conf",
        ],
    }

#   mdct-00fs not using firewall and lokkit will enable it
#   lokkit::tcp_port { "git-daemon":
#       port    => "9418",
#   }

    # No service to manage here.  The git-daemon is spawned by xinetd.

}
