# modules/dart/manifests/abstract/base_node.pp

class dart::abstract::base_node {

    # NOTICE: Any changes made here should also be considered for
    # modules/dart/manifests/classes/mdct-00fs.pp until such time that class
    # can make direct use of this class.

    include 'cachefilesd'
    include 'cron::daemon'
    include 'dart::abstract::packages::base'
    include 'dart::subsys::dns::no_dns_hosts'
    include 'logwatch'

    class { 'ntp':
        allow_clients   => $hostname ? {
            'mdct-0302pi'   => ['10.7.84/22'],
            'mdct-0310pi'   => ['10.31.52/22'],
            'mdct-0314pi'   => ['10.7.212/22'],
            'mdct-47pi'     => ['10.47/16'],
            default => undef,
        },
    }

    include 'openssh_server'
    include 'prophile'
    #include 'selinux'

    class { 'sendmail':
        enable  => $hostname ? {
            'mdct-dev12'    => true,
            'tc-util'       => true,
            default         => false,
        },
    }

    include 'sudo'

    sudo::drop_in { 'mdct':
        source  =>  [
            "puppet:///private-host/sudo/mdct",
            "puppet:///private-domain/sudo/mdct",
        ],
    }

    include 'timezone'

    if  $operatingsystem == 'Fedora' and
        $operatingsystemrelease == 'Rawhide' or
        $operatingsystemrelease >= 15
    {
        include 'systemd'
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

    include 'ovirt::guest'

}
