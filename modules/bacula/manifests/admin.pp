# modules/bacula/manifests/admin.pp
#
# Synopsis:
#       Configures a host with Bacula administration tools.
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


class bacula::admin (
    $dir_address, $dir_name, $dir_passwd,
    ) {

    include 'bacula::params'

    package { $bacula::params::admin_packages:
        ensure  => installed,
    }

    File {
        owner       => 'root',
        group       => 'bacula',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$bacula::params::admin_packages],
        # It seems only the bacula-client package provides the bacula group.
        # TODO: prove and file a BZ
        require     => Class['bacula::client'],
    }

    file { '/etc/bacula/bat.conf':
        content => template('bacula/bat.conf'),
    }

}
