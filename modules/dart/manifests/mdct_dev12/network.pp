# modules/dart/manifests/mdct_dev12/network.pp
#
# == Class: dart::mdct_dev12::network
#
# Manages network resources on John Florian's workstation.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_dev12::network {

    class { '::network':
        service      => 'nm',
        domain       => $dart::params::dns_domain,
        name_servers => $dart::params::dns_servers,
    }

    network::interface {
        'br0':
            template   => 'static-bridge',
            ip_address => '10.209.23.1',
            netmask    => '255.255.252.0',
            gateway    => '10.209.23.254',
            stp        => 'no',
            ;

        'enp0s25':
            template => 'static',
            bridge   => 'br0',
            ;
    }

    iptables::rules_file { 'blocks':
        source  => 'puppet:///modules/dart/mdct-dev12/iptables/blocks',
    }

}
