# modules/iptables/manifests/init.pp
#
# Synopsis:
#       Configures the iptables service(s) on a host.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       managed_host    1       when false, iptables::tcp_port and
#                               iptables::udp_port become a no-op for the
#                               host
#
#       enabled         1       service is to be enabled and running
#
#       kernel_modules  2       additional kernel modules to be loaded, e.g.,
#                               for conntrack support
#
# Notes:
#
#       1. Default is true.
#
#       2. Default is ''.  Specify as a space-separated list.


class iptables($managed_host=true, $enabled=true, $kernel_modules='') {

    include 'iptables::params'

    yum::remove { $iptables::params::conflicting_packages:
        before  => Package[$iptables::params::packages],
    }

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

    if $::operatingsystem == 'Fedora' and $::operatingsystemrelease < 16 {
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
