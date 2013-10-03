# modules/apache/manifests/init.pp
#
# Synopsis:
#       Configures a host as an Apache HTTP server.
#
# Parameters:
#       NONE
#
# Requires:
#       NONE


class apache ($use_nfs='off', $network_connect_db='off') {

    package { 'httpd':
        ensure  => installed,
    }

    file { '/etc/httpd/conf/httpd.conf':
        # New templates are best made from pristine copies from the target OS
        # with local changes applied atop that.
        content => template("apache/httpd.conf.${operatingsystem}.${operatingsystemrelease}"),
        group   => 'root',
        mode    => '0640',
        owner   => 'root',
        require => Package['httpd'],
    }

    selinux::boolean {
        'httpd_use_nfs':
            persistent      => true,
            value           => $use_nfs;
        'httpd_can_network_connect_db':
            persistent      => true,
            value           => $network_connect_db;
    }

    iptables::tcp_port {
        'http': port => '80';
    }

    service { 'httpd':
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        require     => Package['httpd'],
        subscribe   => File['/etc/httpd/conf/httpd.conf'],
    }

}
