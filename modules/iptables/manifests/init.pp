# modules/iptables/manifests/init.pp
#
# Synopsis:
#       Configures the iptables and ip6tables services on a host.
#
# Parameters:
#       $enabled       services enabled: true (default) or false
#
# Requires:
#
# Example usage:
#
#       class { 'iptables':
#           enabled => false,
#       }

class iptables($enabled, $kernel_modules='') {

    package { ['iptables', 'iptables-ipv6']:
        ensure  => installed,
    }

    file { '/etc/sysconfig/iptables-config':
	content	=> template('iptables/iptables-config'),
        group	=> 'root',
        mode    => '0600',
        owner   => 'root',
        require => Package['iptables'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'system_conf_t',
    }

    file { '/etc/sysconfig/ip6tables-config':
	content	=> template('iptables/ip6tables-config'),
        group	=> 'root',
        mode    => '0600',
        owner   => 'root',
        require => Package['iptables-ipv6'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'system_conf_t',
    }

    service { 'iptables':
        enable          => $enabled,
        ensure          => $enabled,
        hasrestart      => true,
        hasstatus       => false,   # it does, but always exits 0
        require         => [
            Package['iptables'],
        ],
        # weak strategy, best so far: look for rules prefixed with a line
        # number
        status          => '(iptables -L --line-numbers; iptables -L -t nat --line-numbers) | grep -q "^[0-9]"',
        subscribe       => File['/etc/sysconfig/iptables-config'],
    }

    service { 'ip6tables':
        enable          => $enabled,
        ensure          => $enabled,
        hasrestart      => true,
        hasstatus       => false,   # it does, but always exits 0
        require         => [
            Package['iptables-ipv6'],
        ],
        # weak strategy, best so far: look for rules prefixed with a line
        # number
        status          => 'ip6tables -L --line-numbers | grep -q "^[0-9]"',
        subscribe       => File['/etc/sysconfig/ip6tables-config'],
    }

}
