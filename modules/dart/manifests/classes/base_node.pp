# /etc/puppet/modules/dart/manifests/classes/base_node.pp

class dart::base_node {
    include authconfig
    include autofs
    # include cups
    include cachefilesd
    include ntp
    include openssh-server
    include packages::base
    include puppet
    include rpcidmapd
    include sudo
    include timezone
    include xorg-server
}
