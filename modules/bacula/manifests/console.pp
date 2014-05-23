# modules/bacula/manifests/console.pp
#
# Synopsis:
#       Configures the Bacula Console on a host.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name; not used
#
#       dir_address             hostname/IP of Director
#
#       dir_name                the Director's name
#
#       dir_passwd              pasword authorizing connections to the
#                               Director for full privileges
#
# Notes:
#
#       NONE


class bacula::console (
    $dir_address, $dir_name, $dir_passwd,
    ) {

    include 'bacula::params'

    package { $bacula::params::con_packages:
        ensure  => installed,
    }

    File {
        owner       => 'root',
        group       => 'bacula',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$bacula::params::con_packages],
    }

    file { '/etc/bacula/bconsole.conf':
        content => template('bacula/bconsole.conf'),
    }

}
