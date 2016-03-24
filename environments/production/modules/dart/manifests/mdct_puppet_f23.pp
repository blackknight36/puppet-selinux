# modules/dart/manifests/mdct_puppet_f23.pp
#
# Synopsis:
#       Puppet Master(s)
#
# Contact:
#       Michael Watters

class dart::mdct_puppet_f23 inherits dart::abstract::puppet_server_node {

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
