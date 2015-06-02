# modules/dart/manifests/abstract/base_node.pp
#
# NOTICE:
#       Any changes made here should also be considered for
#       modules/dart/manifests/classes/mdct-00fs.pp until such time that class
#       can make direct use of this class.


class dart::abstract::base_node {

    #
    # TODO: Replace these selectors with polymorphism and/or hiera.
    #
    $allow_ntp_clients = $::hostname ? {
        'mdct-0302pi'   => ['10.7.84/22'],
        'mdct-0310pi'   => ['10.31.52/22'],
        'mdct-0314pi'   => ['10.7.212/22'],
        'mdct-47pi'     => ['10.47/16'],
        default         => undef,
    }

    $yum_conf_source = $::hostname ? {
        /^mdct-ovirt-/  => 'puppet:///modules/dart/yum/yum-proxied.conf',
        default         => 'puppet:///modules/dart/yum/yum.conf',
    }

    if $::hostname != 'mdct-00fs' {
        # The authconfig class lowers the default min_id value, which must be
        # done early to ensure that installation of any package which may
        # create user/group accounts does so according to the non-standard
        # min_id value.
        class { '::authconfig':
            stage => 'early',
        }

        class { '::nfs::client':
            # While we don't use Kerberos for NFS authentication, it helps to
            # have it enabled for older Fedora releases.  See commit 948e0c47.
            # It certainly is not necessary starting with Fedora 21 though
            # since the service won't even start if the keytab file isn't
            # present.
            use_gss => true,
        }

    }

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
    include '::sendmail'
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
