# modules/dart/manifests/mdct_puppet_f21.pp
#
# Synopsis:
#       Legacy Puppet Master
#
# Contact:
#       Michael Watters

class dart::mdct_puppet_f21 inherits dart::abstract::puppet_server_node {

    include '::network'
    include 'puppet::server::tagmail'

    ::network::interface { 'eth0':
        template   => 'static',
        ip_address => '10.201.64.46',
        netmask    => '255.255.252.0',
        gateway    => '10.201.67.254',
        stp        => 'no',
    }

    class { 'jaf_bacula::client':
        dir_name   => $dart::params::bacula_dir_name,
        dir_passwd => 'WnB1NCb0T5WEcac5OtHdX47fi7vFreLMicbbt9jsizuC',
        mon_name   => $dart::params::bacula_mon_name,
        mon_passwd => 'QGnCsKgAgta41AUGHiKVOveXHUJaphdQwyRQYH2ox0xt',
    }

    iptables::rules_file { 'blocks':
        source  => "puppet:///modules/files/private/${fqdn}/iptables/blocks",
    }

    file { '/etc/motd':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => "puppet:///modules/files/private/${fqdn}/motd",
    }

}
