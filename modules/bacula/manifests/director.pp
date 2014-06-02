# modules/bacula/manifests/director.pp
#
# == Class: bacula::director
#
# Configures the Bacula Director Daemon on a host.
#
# === Parameters
#
# [*dir_conf*]
#   Content of the Bacula Director's configuration.
#
# [*pgpass_source*]
#   URI of the Postgres password file.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class bacula::director ($dir_conf, $pgpass_source) {

    include 'bacula::common'
    include 'bacula::dir_sd_common'
    include 'bacula::params'

    package { $bacula::params::dir_packages:
        ensure  => installed,
        notify  => Service[$bacula::params::dir_service_name],
    }

    File {
        owner       => 'root',
        group       => 'bacula',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$bacula::params::dir_service_name],
        notify      => Service[$bacula::params::dir_service_name],
        subscribe   => [
            Package[$bacula::params::common_packages],
            Package[$bacula::params::dir_packages],
            Package[$bacula::params::dir_sd_common_packages],
        ]
    }

    file { '/etc/bacula/backup_conf_files':
        mode    => '0750',
        source  => 'puppet:///modules/bacula/backup_conf_files',
    }

    file { '/etc/bacula/bacula-dir.conf':
        content => "${dir_conf}",
    }

    file { '/etc/bacula/director':
        ensure  => directory,
    }

    file { '/root/.pgpass':
        mode    => '0600',
        seltype => 'admin_home_t',
        source  => "${pgpass_source}",
    }

    iptables::tcp_port {
        'bacula-dir':   port => '9101';
    }

    service { $bacula::params::dir_service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        subscribe   => Class['postgresql::server'],
    }

}
