# modules/git_daemon/manifests/init.pp

class git_daemon {

    package { "git-daemon":
        ensure  => installed,
    }

    file { "/etc/xinetd.d/git":
        group   => "root",
        mode    => "0644",
        owner   => "root",
        require => Package["git-daemon"],
        seluser => "system_u",
        selrole => "object_r",
        seltype => "etc_t",
        source  => [
            "puppet:///modules/files/private/${fqdn}/git_daemon/xinetd-git.conf",
            "puppet:///modules/git_daemon/xinetd-git.conf",
        ],
    }

#   mdct-00fs not using firewall and iptables::tcp_port would enable it
#   iptables::tcp_port {
#       'git-daemon':   port => '9418';
#   }

    # No service to manage here.  The git-daemon is spawned by xinetd.

}
