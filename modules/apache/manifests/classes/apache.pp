# modules/apache/manifests/classes/apache.pp
#
# Synopsis:
#       Configures a host as an Apache HTTP server.
#
# Parameters:
#       NONE
#
# Requires:
#       NONE
#
# Example usage:
#
#       include 'apache'


class apache {

    include 'lokkit'

    package { 'httpd':
        ensure  => installed,
    }

    file { '/etc/httpd/conf/httpd.conf':
        # New templates are best made from pristine copies from the target OS
        # with local changes applied atop that.
        content	=> template("apache/httpd.conf.${operatingsystem}.${operatingsystemrelease}"),
        group   => 'root',
        mode    => '0640',
        owner   => 'root',
        require => Package['httpd'],
    }

    # Web content is reached via NFS, so selinux must be adjusted to allow the
    # apache daemon to access it.
    selboolean { 'httpd_use_nfs':
        persistent      => true,
        value           => on,
    }

    lokkit::tcp_port { 'http':
        port    => '80',
    }

    service { 'httpd':
        enable          => true,
        ensure          => running,
        hasrestart      => true,
        hasstatus       => true,
        require         => [
            Exec['open-http-tcp-port'],
            Package['httpd'],
            Selboolean['httpd_use_nfs'],
        ],
        subscribe       => [
            File['/etc/httpd/conf/httpd.conf'],
        ],
    }

}
