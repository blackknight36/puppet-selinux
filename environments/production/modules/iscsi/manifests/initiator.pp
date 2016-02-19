# modules/iscsi/manifests/initiator.pp
#
# == Class: iscsi::initiator
#
# Configures a host as an iSCSI initiator.
#
# === Parameters
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class iscsi::initiator {

    include 'iscsi::params'

    package { $iscsi::params::packages:
        ensure  => installed,
        # The service is started on demand (by systemd) in response to socket
        # connections, thus no need to notify things that aren't already
        # running.
        #
        # notify  => Service[$iscsi::params::service_name],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$iscsi::params::service_name],
        notify      => Service[$iscsi::params::service_name],
        subscribe   => Package[$iscsi::params::packages],
    }

    service { $iscsi::params::service_name:
        enable      => true,
        hasrestart  => true,
        hasstatus   => true,
        provider    => 'systemd',
    }

}
