# modules/bacula/manifests/admin.pp
#
# == Class: jaf_bacula::admin
#
# Configures the Bacula administration tools on a host.
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


class jaf_bacula::admin (
    $dir_address, $dir_name, $dir_passwd,
    ) {

    include 'jaf_bacula::params'

    package { $jaf_bacula::params::admin_packages:
        ensure  => installed,
    }

    File {
        owner       => 'root',
        group       => 'bacula',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$jaf_bacula::params::admin_packages],
        # It seems only the bacula-client package provides the bacula group.
        # TODO: prove and file a BZ
        require     => Class['jaf_bacula::client'],
    }

    file { '/etc/bacula/bat.conf':
        content => template('jaf_bacula/bat.conf'),
    }

}
