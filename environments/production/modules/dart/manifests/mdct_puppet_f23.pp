# modules/dart/manifests/mdct_puppet_f23.pp
#
# Synopsis:
#       Puppet Master(s)
#
# Contact:
#       Michael Watters

class dart::mdct_puppet_f23 {

    class { 'puppet::server' :
        use_passenger => false,
        use_puppetdb  => true,
        cert_name     => $::fqdn,
    }

    include 'puppet::server::tagmail'

    iptables::rules_file { 'blocks':
        source  => 'puppet:///private-host/iptables/blocks',
    }

    file { '/etc/motd':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///private-host/motd',
    }

}
