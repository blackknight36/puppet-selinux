# modules/vsftpd/manifests/init.pp
#
# Synopsis:
#       Configures a host as a vsftpd server.
#
# Parameters:
#       $allow_use_nfs  true/false      Configure SELinux to permit vsftpd to
#                                       export content residing on NFS.
#
# Requires:
#       NONE
#
# Example usage:
#
#       class { 'vsftpd':
#           allow_use_nfs      => true,
#       }

class vsftpd($allow_use_nfs=false) {

    include lokkit

    package { 'vsftpd':
	ensure	=> installed,
    }

    file { '/etc/vsftpd/vsftpd.conf':
        group	=> 'root',
        mode    => '0600',
        owner   => 'root',
        require => Package['vsftpd'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        source  => [
            'puppet:///private-host/vsftpd/vsftpd.conf',
            'puppet:///private-domain/vsftpd/vsftpd.conf',
            'puppet:///modules/vsftpd/vsftpd.conf',
        ],
    }

    lokkit::tcp_port { 'vsftpd':
        port    => '21',
    }

    if $selinux == 'true' {
        selboolean { 'allow_ftpd_use_nfs':
            before      => Service['vsftpd'],
            persistent  => true,
            value       => $allow_use_nfs ? {
                true    => on,
                default => off,
            }
        }
    }

    service { 'vsftpd':
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec['open-vsftpd-tcp-port'],
            Package['vsftpd'],
        ],
        subscribe	=> [
            File['/etc/vsftpd/vsftpd.conf'],
        ],
    }

}
