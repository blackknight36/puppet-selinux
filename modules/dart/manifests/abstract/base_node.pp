# modules/dart/manifests/abstract/base_node.pp

class dart::abstract::base_node {

    #
    # TODO: Replace these selectors with polymorphism.
    #
    $allow_ntp_clients = $::hostname ? {
        'mdct-0302pi'   => ['10.7.84/22'],
        'mdct-0310pi'   => ['10.31.52/22'],
        'mdct-0314pi'   => ['10.7.212/22'],
        'mdct-47pi'     => ['10.47/16'],
        default         => undef,
    }

    $enable_sendmail = $::hostname ? {
        'mdct-dev12'        => true,
        'tc-util'           => true,
        /^mdct-aos-master/  => true,
        /^mdct-est-/        => true,
        default             => false,
    }

    $yum_conf_source = $::hostname ? {
        /^mdct-ovirt-/  => 'puppet:///modules/dart/yum/yum-proxied.conf',
        default         => 'puppet:///modules/dart/yum/yum.conf',
    }

    # NOTICE: Any changes made here should also be considered for
    # modules/dart/manifests/classes/mdct-00fs.pp until such time that class
    # can make direct use of this class.

    include 'cachefilesd'
    include 'cron::daemon'
    include 'dart::abstract::packages::base'
    include 'dart::subsys::dns::no_dns_hosts'
    include 'dart::subsys::filesystem'
    include 'logwatch'

    class { 'ntp':
        allow_clients   => $allow_ntp_clients,
    }

    class { 'openssh::server':
        source  => [
            'puppet:///private-host/openssh/sshd_config',
            'puppet:///private-domain/openssh/sshd_config',
            "puppet:///modules/dart/openssh/sshd_config.${::operatingsystem}.${::operatingsystemrelease}",
        ],
    }

    include 'prophile'
    #include 'selinux'

    class { 'sendmail':
        enable  => $enable_sendmail,
    }

    include 'sudo'

    sudo::drop_in { 'mdct':
        source  =>  [
            'puppet:///private-host/sudo/mdct',
            'puppet:///private-domain/sudo/mdct',
        ],
    }

    include 'timezone'

    if  $::operatingsystem == 'Fedora' and
        $::operatingsystemrelease == 'Rawhide' or
        $::operatingsystemrelease >= 15
    {
        include 'systemd'
    }

    class { 'yum':
        conf_source => $yum_conf_source,
        stage       => 'first';
    }

    class { '::dart::subsys::yum::dart':
        require => Class['yum'],
        stage   => 'first',
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
