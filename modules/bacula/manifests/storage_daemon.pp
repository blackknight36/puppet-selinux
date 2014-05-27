# modules/bacula/manifests/storage_daemon.pp
#
# == Class: bacula::storage_daemon
#
# Configures a host as a Bacula Storage Daemon.
#
# === Parameters
#
# [*dir_name*]
#   The name of the Bacula Director.
#
# [*mon_name*]
#   The name of the Bacula Monitor.
#
# [*mon_passwd*]
#   The password authorizing connections to the Bacula Director, albeit with
#   restricted (i.e., monitoring) privileges.
#
# [*sd_name*]
#   The name of the Bacula Storage Daemon.
#
# [*sd_passwd*]
#   The password authorizing connections to this Bacula Storage Daemon.
#
# [*sd_archive_dev*]
#   The name of the device where this Bacula Storage Daemon will write backup
#   archives (AKA volumes).
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


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
