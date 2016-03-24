# modules/dart/manifests/abstract/base_node.pp
#
# == Class: dart::abstract::base_node
#
# Manages numerous resources common to all Dart hosts.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   Michael Watters <michael.watters@dart.biz>


class dart::abstract::base_node {

    # The authconfig class lowers the default min_id value, which must be done
    # early to ensure that installation of any package which may create
    # user/group accounts does so according to the non-standard min_id value.
    class { '::authconfig':
        stage => 'early',
    }

    class { '::nfs::client':
        # While we don't use Kerberos for NFS authentication, it helps to have
        # it enabled for older Fedora releases.  See commit 948e0c47.  It
        # certainly is not necessary starting with Fedora 21 though since the
        # service won't even start if the keytab file isn't present.
        use_gss => true,
    }

    include '::chrony'
    include '::cron::daemon'
    include '::dart::abstract::packages::base'
    include '::dart::subsys::dns::no_dns_hosts'
    include '::dart::subsys::filesystem'
    include '::logwatch'
    include '::lvm_snapshot_tools'
    include '::openssh::server'
    include '::ovirt::guest'
    include '::puppet::client'
    if $::operatingsystem != 'CentOS' {
        include '::prophile'
    }
    #include '::selinux'
    include '::sendmail'
    include '::sudo'

    if $::operatingsystem == 'Fedora' and $::operatingsystemrelease >= '21' {
        include '::openssl::ca_certificate::dart'
    }

    ::sudo::drop_in { 'mdct':
        source  => hiera('sudo::drop_in::source'),
    }

    if  $::operatingsystem == 'Fedora' and
        $::operatingsystemrelease == 'Rawhide' or
        $::operatingsystemrelease >= '15'
    {
        include '::systemd'
    }

    include '::timezone'

    class { '::yum':
        stage => 'first',
    }

    class { '::dart::subsys::yum::dart':
        require => Class['yum'],
        stage   => 'first',
    }

    if $operatingsystem == 'Fedora' {
        class { '::dart::subsys::yum::fedora':
            require => Class['yum'],
            stage   => 'first',
        }
    }

    class { '::dart::subsys::yum::mdct':
        require => Class['yum'],
        stage   => 'first',
    }

}
