# modules/dart/manifests/abstract/base_node.pp

class dart::abstract::base_node {

    # NOTICE: Any changes made here should also be considered for
    # modules/dart/manifests/classes/mdct-00fs.pp until such time that class
    # can make direct use of this class.

    include cron::daemon
    include cachefilesd
    include dart::no-dns-hosts
    include logwatch
    include ntp
    include openssh-server
    include packages::base
    #include selinux
    include sudo
    include timezone

    if  $operatingsystem == 'Fedora' and
        $operatingsystemrelease == 'Rawhide' or
        $operatingsystemrelease >= 15
    {
        include systemd
    }

}
