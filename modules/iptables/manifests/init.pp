# modules/iptables/manifests/init.pp
#
# Synopsis:
#       Configures the iptables service(s) on a host.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       enabled                 service is to be enabled and running
#
#       kernel_modules  1       additional kernel modules to be loaded, e.g.,
#                               for conntrack support
#
# Notes:
#
#       1. Default is ''.


class iptables($enabled, $kernel_modules='') {

    include 'iptables::params'

    package { $iptables::params::packages:
        ensure  => installed,
        notify  => Service[$iptables::params::services],
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0600',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'system_conf_t',
        before      => Service[$iptables::params::services],
        notify      => Service[$iptables::params::services],
        subscribe   => Package[$iptables::params::packages],
    }

    file { '/etc/sysconfig/iptables-config':
        content => template('iptables/iptables-config'),
    }

    file { '/etc/sysconfig/ip6tables-config':
        content => template('iptables/ip6tables-config'),
    }

    Service {
        enable      => $enabled,
        ensure      => $enabled,
        hasrestart  => true,
        hasstatus   => true,
    }

    if $operatingsystem == 'Fedora' and $operatingsystemrelease < 16 {
        service { 'iptables':
            hasstatus   => false,   # it does, but always exits 0
            # weak strategy, best so far: look for rules prefixed with a line
            # number
            status      => '(iptables -L --line-numbers; iptables -L -t nat --line-numbers) | grep -q "^[0-9]"',
        }

        service { 'ip6tables':
            hasstatus   => false,   # it does, but always exits 0
            # weak strategy, best so far: look for rules prefixed with a line
            # number
            status      => 'ip6tables -L --line-numbers | grep -q "^[0-9]"',
        }
    } else {
        # Fedora 16 introduces systemd, which provides sane status support ...
        service { $iptables::params::services:
            enable      => $enabled,
            ensure      => $enabled,
            hasrestart  => true,
            hasstatus   => true,
        }
    }

}
