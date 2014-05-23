# modules/bacula/manifests/storage_daemon.pp
#
# Synopsis:
#       Configures the Bacula Storage Daemon on a host.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name; not used
#
#       dir_name                the Director's name
#
#       mon_name                the Monitor's name
#
#       mon_passwd              pasword authorizing connections to the
#                               Director for restricted privileges
#
#       sd_name                 the Storage Daemon's name
#
#       sd_address              hostname/IP of Storage Daemon
#
#       sd_passwd               pasword authorizing connections to this
#                               Storage Daemon
#
#       sd_archive_dev          Device name where Storage Daemon will write
#                               backup archives (AKA volumes).
#
# Notes:
#
#       NONE


class bacula::storage_daemon (
    $dir_name,
    $mon_name, $mon_passwd,
    $sd_name, $sd_passwd, $sd_archive_dev,
    ) {

    include 'bacula::common'
    include 'bacula::dir_sd_common'
    include 'bacula::params'

    $external_package_deps = [
        Package[$bacula::params::common_packages],
        Package[$bacula::params::dir_sd_common_packages],
    ]

    package { $bacula::params::sd_packages:
        ensure  => installed,
        notify  => Service[$bacula::params::sd_service_name],
    }

    File {
        owner       => 'root',
        group       => 'bacula',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$bacula::params::sd_service_name],
        notify      => Service[$bacula::params::sd_service_name],
        subscribe   => [
            Package[$bacula::params::sd_packages],
            $external_package_deps,
        ]
    }

    file { '/etc/bacula/bacula-sd.conf':
        content => template('bacula/bacula-sd.conf'),
    }

    iptables::tcp_port {
        'bacula-sd':    port   => '9103';
    }

    service { $bacula::params::sd_service_name:
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        subscribe   => $external_package_deps,
    }

}
