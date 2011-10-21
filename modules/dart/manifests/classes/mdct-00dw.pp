# /etc/puppet/modules/dart/manifests/classes/mdct-00dw.pp

class dart::mdct-00dw inherits dart::server_node {

    class { 'iptables':
        enabled => true,
    }

}
