# modules/vsftpd/manifests/init.pp
#
# Synopsis:
#       Configures a host as a vsftpd server.
#
# Parameters:
#       NONE
#
# Requires:
#       Class['postgresql::server']     <= Use this notation for other resources
#
#       $vsftpd_var1                       Abstract variable 1
#       $vsftpd_var2                       Abstract variable 2
#       $vsftpd_CONFIG_NAME_source         Source URI for the vsftpd.conf file
#
# Example usage:
#
#       $vsftpd_var1 = 'X_foo'
#       $vsftpd_var2 = 'X_bar'
#       $vsftpd_CONFIG_NAME_source = 'puppet:///private-host/vsftpd.conf'
#       include vsftpd

class vsftpd {

    include lokkit

#   case $vsftpd_CONFIG_NAME_source {
#       '': {
#           fail('Required $vsftpd_CONFIG_NAME_source variable is not defined')
#       }
#   }

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
