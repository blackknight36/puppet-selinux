# modules/iptables/manifests/init.pp
#
# Synopsis:
#       Configures the iptables service on a host.
#
# Parameters:
#       $enabled       service enabled: true (default) or false
#
# Requires:
#
# Example usage:
#
#       class { 'iptables':
#           enabled => false,
#       }

class iptables($enabled, $kernel_modules='') {

    package { 'iptables':
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

}
