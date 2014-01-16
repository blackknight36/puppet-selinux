# modules/openssh_server/manifests/init.pp
#
# Synopsis:
#       Configures a host as a OpenSSH server server.
#
# Parameters:
#       NONE
#
# Requires:
#       NONE
#
# Example usage:
#
#       include 'openssh_server'

class openssh_server {

    package { 'openssh-server':
        ensure  => installed,
    }

    file { '/etc/ssh/sshd_config':
        group   => 'root',
        mode    => 600,
        owner   => 'root',
        require => Package['openssh-server'],
        source  => [
            'puppet:///private-host/openssh_server/sshd_config',
            'puppet:///private-domain/openssh_server/sshd_config',
            "puppet:///modules/openssh_server/sshd_config.$operatingsystem.$operatingsystemrelease",
        ],
    }

    iptables::tcp_port {
        'ssh':  port => '22';
    }

    service { 'sshd':
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        require     => Package['openssh-server'],
        subscribe   => File['/etc/ssh/sshd_config'],
    }

}
