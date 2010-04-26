# /etc/puppet/modules/dart/manifests/classes/base_node.pp

class dart::base_node {
    include authconfig
    include autofs
    # include cups
    include nscd
    include ntp
    include openssh-server
    include pam
    include pkgs_base
    include puppet
    include rpcidmapd
    include storage-relocation
    include sudo
    include timezone
    # include unwanted-services
    include xorg-server
}
