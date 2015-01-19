# modules/nfs/manifests/rpcidmapd.pp
#
# == Class: nfs::rpcidmapd
#
# Manages the NFS ID Mapper daemon on a host.
#
# === Parameters
#
# [*domain*]
#   Name of the NFS domain.  Defaults to the "domain" fact.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>


class nfs::rpcidmapd (
        $domain=$::domain,
    ) {

    include 'nfs::params'
    include 'nfs::utils'

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$nfs::params::idmap_service],
        notify      => Service[$nfs::params::idmap_service],
        subscribe   => Package[$nfs::params::utils_packages],
    }

    file { '/etc/idmapd.conf':
        content => template('nfs/idmapd.conf'),
    }

    if $nfs::params::kernel_options != undef {
        file { '/etc/modprobe.d/nfs.conf':
            mode    => '0644',
            seltype => 'modules_conf_t',
            content => "${nfs::params::kernel_options}\n",
        }
    }

#   TODO: presently causes dependency loop
#   firewall { '500 accept NFS-callback packets':
#       dport  => $nfs::params::callback_tcpport,
#       proto  => 'tcp',
#       state  => 'NEW',
#       action => 'accept',
#   }

    service { $nfs::params::idmap_service:
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
    }

}
