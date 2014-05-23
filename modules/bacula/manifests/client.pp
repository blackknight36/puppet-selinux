# modules/bacula/manifests/client.pp
#
# Synopsis:
#       Configures the Bacula File (Client) Daemon on a host.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    instance name; not used
#
#       dir_name                the Director's name
#
#       dir_passwd              pasword authorizing connections to the
#                               Director for full privileges
#
#       mon_name                the Monitor's name
#
#       mon_passwd              pasword authorizing connections to the
#                               Director for restricted privileges
#
# Notes:
#
#       NONE


class bacula::client (
    $dir_name, $dir_passwd,
    $mon_name, $mon_passwd,
    ) {

    include 'bacula::common'
    include 'bacula::params'

    package { $bacula::params::fd_packages:
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
            Package[$bacula::params::common_packages],
            Package[$bacula::params::fd_packages],
        ]
    }

    file { '/etc/bacula/bacula-fd.conf':
        content	=> template('bacula/bacula-fd.conf'),
    }

    file { '/etc/sysconfig/bacula-fd':
        source  => 'puppet:///modules/bacula/bacula-fd',
    }

    iptables::tcp_port {
        'bacula-fd':    port => '9102';
    }

    service { $bacula::params::fd_service_name:
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        subscribe       => [
            File['/etc/bacula/bacula-fd.conf'],
            File['/etc/sysconfig/bacula-fd'],
            Package[$bacula::params::common_packages],
            Package[$bacula::params::fd_packages],
        ],
    }

}
