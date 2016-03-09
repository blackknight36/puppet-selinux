# modules/nfs/manifests/rpcidmapd.pp
#
# == Class: nfs::rpcidmapd
#
# Manages the NFS ID Mapper daemon on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*domain*]
#   Name of the NFS domain.  Defaults to the "domain" fact.
#
# [*enable*]
#   Instance is to be started at boot.  Either true (default) or false.
#
# [*ensure*]
#   Instance is to be 'running' (default) or 'stopped'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>
#   Michael Watters <michael.watters@dart.biz>


class nfs::rpcidmapd (
        $domain=$::domain,
        $enable=true,
        $ensure='running',
    ) inherits ::nfs::params {

    include '::nfs::utils'

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$::nfs::params::idmap_service],
        notify      => Service[$::nfs::params::idmap_service],
        subscribe   => Package[$::nfs::params::utils_packages],
    }

    file { '/etc/idmapd.conf':
        content => template('nfs/idmapd.conf'),
    }

    if $::nfs::params::kernel_options != undef {
        file { '/etc/modprobe.d/nfs.conf':
            mode    => '0644',
            seltype => 'modules_conf_t',
            content => "${::nfs::params::kernel_options}\n",
        }
    }

#   TODO: presently causes dependency loop
#   firewall { '500 accept NFS-callback packets':
#       dport  => $::nfs::params::callback_tcpport,
#       proto  => 'tcp',
#       state  => 'NEW',
#       action => 'accept',
#   }

    $idmap_ensure = $::nfs::params::idmap_service_is_static ? {
        true => 'stopped',
        default => true,
    }

    $idmap_enable = $::nfs::params::idmap_service_is_static ? {
        true => undef,
        default => true,
    }

    service { $::nfs::params::idmap_service:
        ensure     => $idmap_ensure,
        enable     => $idmap_enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
