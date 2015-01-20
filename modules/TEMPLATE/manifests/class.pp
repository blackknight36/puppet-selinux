# modules/MODULE_NAME/manifests/CLASS_NAME.pp
#
# == Class: MODULE_NAME::CLASS_NAME
#
# Manages the MODULE_NAME CLASS_NAME on a host.
#
# === Parameters
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*content*]
#   Literal content for the MODULE_NAME CLASS_NAME file.  If neither "content"
#   nor "source" is given, the content of the file will be left unmanaged.
#
# [*source*]
#   URI of the MODULE_NAME CLASS_NAME file content.  If neither "content"
#   nor "source" is given, the content of the file will be left unmanaged.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>


class MODULE_NAME::CLASS_NAME (
        $ensure='present',
        $content=undef,
        $source=undef,
    ) {

    include 'MODULE_NAME::params'

    package { $MODULE_NAME::params::packages:
        ensure => installed,
        notify => Service[$MODULE_NAME::params::service_name],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$MODULE_NAME::params::service_name],
        notify      => Service[$MODULE_NAME::params::service_name],
        subscribe   => Package[$MODULE_NAME::params::packages],
    }

    file { '/CONFIG_PATH/CONFIG_NAME':
        content => $content,
        source  => $source,
    }

    iptables::tcp_port {
        'SERVICE_NAME': port => 'SERVICE_PORT_1';
        'SERVICE_NAME': port => 'SERVICE_PORT_2';
    }

    Selinux::Boolean {
        before      => Service[$MODULE_NAME::params::service_name],
        persistent  => true,
    }

    selinux::boolean { $MODULE_NAME::params::bool_name1:
        value => $allow_use_nfs ? {
            true    => on,
            default => off,
        }
    }

    service { $MODULE_NAME::params::service_name:
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
    }

}
