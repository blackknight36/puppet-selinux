# /etc/puppet/modules/dart/manifests/classes/base_node.pp

class dart::base_node {
    include authconfig
    include autofs
    include cups
    include cachefilesd
    include dart::no-dns-hosts
    include logwatch
    include ntp
    include openssh-server
    include packages::base
    include puppet::client
    include rpcidmapd
    include sudo
    include timezone
    include xorg-server
}
