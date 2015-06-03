# modules/dart/manifests/abstract/base_node.pp
#
# NOTICE:
#       Any changes made here should also be considered for
#       modules/dart/manifests/classes/mdct-00fs.pp until such time that class
#       can make direct use of this class.


class dart::abstract::base_node {

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
    include '::chrony'
    include 'cron::daemon'
    include 'dart::abstract::packages::base'
    include 'dart::subsys::dns::no_dns_hosts'
    include 'dart::subsys::filesystem'
    include 'logwatch'
    include '::openssh::server'
    include 'prophile'
    #include 'selinux'
    include '::sendmail'
    include 'sudo'

    sudo::drop_in { 'mdct':
        source  => hiera('sudo::drop_in::source'),
    }

    include 'timezone'

    if  $::operatingsystem == 'Fedora' and
        $::operatingsystemrelease == 'Rawhide' or
        $::operatingsystemrelease >= 15
    {
        include 'systemd'
    }

    class { '::yum':
        stage => 'first',
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
