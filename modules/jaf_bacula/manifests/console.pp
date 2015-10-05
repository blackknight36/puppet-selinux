# modules/bacula/manifests/console.pp
#
# == Class: jaf_bacula::console
#
# Configures the Bacula Console on a host.
#
# === Parameters
#
# [*dir_address*]
#   The hostname or IP address where the Bacula Director can be reached.
#
# [*dir_name*]
#   The name of the Bacula Director.
#
# [*dir_passwd*]
#   The password authorizing connections to the Bacula Director, with
#   unrestricted privileges.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class jaf_bacula::console (
    $dir_address, $dir_name, $dir_passwd,
    ) {

    include 'jaf_bacula::params'

    package { $jaf_bacula::params::con_packages:
        ensure  => installed,
    }

    File {
        owner       => 'root',
        group       => 'bacula',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$jaf_bacula::params::con_packages],
    }

    file { '/etc/bacula/bconsole.conf':
        content => template('jaf_bacula/bconsole.conf'),
    }

}