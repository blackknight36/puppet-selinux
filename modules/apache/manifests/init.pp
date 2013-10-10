# modules/apache/manifests/init.pp
#
# Synopsis:
#       Configures a host as an Apache HTTP server.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       anon_write      1,2     allow httpd to modify public files used for
#                               public file transfer services
#
#       network_connect_db
#                       1       allow httpd scripts and modules to connect to
#                               databases over the network
#
#       use_nfs         1       allow httpd to access nfs file systems
#
# Notes:
#
#       1. Default is 'off'.
#
#       2.. Directories/Files must be labeled public_content_rw_t.
#
# Requires:
#       NONE


class apache ($anon_write='off', $network_connect_db='off', $use_nfs='off') {

    include 'apache::params'

    package { $apache::params::packages:
        ensure  => installed,
        notify  => Service[$apache::params::service_name],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'httpd_config_t',
        before      => Service[$apache::params::service_name],
        notify      => Service[$apache::params::service_name],
        subscribe   => Package[$apache::params::packages],
    }

    file { '/etc/httpd/conf/httpd.conf':
        # New templates are best made from pristine copies from the target OS
        # with local changes applied atop that.
        content => template("apache/httpd.conf.${::operatingsystem}.${::operatingsystemrelease}"),
    }

    selinux::boolean {
        $apache::params::bool_anon_write:
            persistent      => true,
            value           => $anon_write;
        $apache::params::bool_can_network_connect_db:
            persistent      => true,
            value           => $network_connect_db;
        $apache::params::bool_use_nfs:
            persistent      => true,
            value           => $use_nfs;
    }

    iptables::tcp_port {
        'http': port => '80';
    }

    service { $apache::params::service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
