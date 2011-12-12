# modules/dart/manifests/classes/base_node.pp

class dart::base_node {

    # NOTICE: Any changes made here should also be considered for
    # modules/dart/manifests/classes/mdct-00fs.pp until such time that class
    # can make direct use of this class.

    include authconfig
    include autofs
    include cron::daemon
    include cups
    include cachefilesd
    include dart::custom-facts
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
