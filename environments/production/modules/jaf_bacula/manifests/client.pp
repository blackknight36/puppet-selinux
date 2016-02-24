# modules/bacula/manifests/client.pp
#
# == Class: jaf_bacula::client
#
# Configures the Bacula File (Client) Daemon on a host.
#
# === Parameters
#
# [*dir_name*]
#   The name of the Bacula Director.
#
# [*dir_passwd*]
#   The password authorizing connections to the Bacula Director, with
#   unrestricted privileges.
#
# [*mon_name*]
#   The name of the Bacula Monitor.
#
# [*mon_passwd*]
#   The password authorizing connections to the Bacula Director, albeit with
#   restricted (i.e., monitoring) privileges.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class jaf_bacula::client (
    $dir_name, $dir_passwd,
    $mon_name, $mon_passwd,
    ) {

    include 'jaf_bacula::common'
    include 'jaf_bacula::params'

    package { $jaf_bacula::params::fd_packages:
        ensure  => installed,
    }

    File {
        owner       => 'root',
        group       => 'bacula',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => [
            Package[$jaf_bacula::params::common_packages],
            Package[$jaf_bacula::params::fd_packages],
        ]
    }

    file { '/etc/bacula/bacula-fd.conf':
        content => template('jaf_bacula/bacula-fd.conf'),
    }

    file { '/etc/sysconfig/bacula-fd':
        source  => 'puppet:///modules/jaf_bacula/bacula-fd',
    }

    iptables::tcp_port {
        'bacula-fd':    port => '9102';
    }

    service { $jaf_bacula::params::fd_service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        subscribe   => [
            File['/etc/bacula/bacula-fd.conf'],
            File['/etc/sysconfig/bacula-fd'],
            Package[$jaf_bacula::params::common_packages],
            Package[$jaf_bacula::params::fd_packages],
        ],
    }

}
