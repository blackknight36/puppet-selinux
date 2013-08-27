# modules/dart/manifests/abstract/base_node.pp

class dart::abstract::base_node {

    # NOTICE: Any changes made here should also be considered for
    # modules/dart/manifests/classes/mdct-00fs.pp until such time that class
    # can make direct use of this class.

    include cron::daemon
    include cachefilesd
    include 'dart::subsys::dns::no_dns_hosts'
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

    class { 'yum':
        conf_source => $hostname ? {
            /^mdct-ovirt-/  => 'puppet:///modules/dart/yum/yum-proxied.conf',
            default         => 'puppet:///modules/dart/yum/yum.conf',
        },
        stage       => 'first';
    }

    class { 'dart::subsys::yum::fedora':
        require => Class['yum'],
        stage   => 'first',
    }

    class { 'dart::subsys::yum::mdct':
        require => Class['yum'],
        stage   => 'first',
    }

}
