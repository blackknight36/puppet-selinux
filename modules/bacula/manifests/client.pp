# modules/bacula/manifests/client.pp
#
# Synopsis:
#       Configures a host as a Bacula client.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       dir_passwd      *none*          Password that the Director should use
#                                       to connect to this client for full
#                                       control.
#
#       mon_passwd      *none*          Password that should be used to
#                                       connect to this client for restricted
#                                       control, chiefly status updates.
#
# Example Usage:
#
#       class { 'bacula::client':
#           dir_passwd      => 'super-secret-squirrel-sauce',
#           mon_passwd      => 'stunningly-saturated-squirrel-sausage',
#       }

class bacula::client($dir_passwd, $mon_passwd) {

    # The introduction of systemd brought subtle configuration changes that
    # must be reflected here.
    if $operatingsystemrelease >= 15 {
        $ossuffix='.Fedora15+'
    } else {
        $ossuffix=''
    }

    # Fedora packages Bacula so that multiple major versions can coexist.  We
    # only need one of them and force the absence of the other primarily to
    # ensure that the other has already been configured and has a service
    # started and listening on the reserved port.  Essentially, we're evicting
    # any potential port squatter.
    $conflict_packages = [ 'bacula2-client', 'bacula2-common', ]

    package { $conflict_packages:
        ensure  => absent,
    }

    package { 'bacula-client':
        ensure  => installed,
        require => Package[$conflict_packages],
    }

    File {
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        require => Package['bacula-client'],
    }

    file { '/etc/bacula/bacula-fd.conf':
        content => template('bacula/bacula-fd.conf'),
    }

    file { '/etc/sysconfig/bacula-fd':
        source  => "puppet:///modules/bacula/bacula-fd${ossuffix}",
    }

    lokkit::tcp_port { 'bacula-fd':
        port    => '9102',
    }

    service { 'bacula-fd':
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        require     => Package['bacula-client'],
        subscribe   => [
            File['/etc/bacula/bacula-fd.conf'],
            File['/etc/sysconfig/bacula-fd'],
        ]
    }

}
