# modules/nfs/manifests/rpcbind.pp
#
# == Class: nfs::rpcbind
#
# Manages the NFS RPC Bind aemon on a host.
#
# The rpcbind utility is a server that converts RPC program numbers into
# universal addresses.  It must be running on the host to be able to make RPC
# calls on a server on that machine.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*enable*]
#   Instance is to be started at boot.  Either true (default) or false.
#
# [*ensure*]
#   Instance is to be 'running' (default) or 'stopped'.
#
# [*manage_firewall*]
#   If true, open the NFS ports on the firewall.  Otherwise the firewall is
#   left unaffected.  Defaults to true.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class nfs::rpcbind (
        $enable=true,
        $ensure='running',
        $manage_firewall=true,
    ) inherits ::nfs::params {

    package { $::nfs::params::bind_packages:
        ensure => installed,
        notify => Service[$::nfs::params::bind_service],
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        before    => Service[$::nfs::params::bind_service],
        notify    => Service[$::nfs::params::bind_service],
        subscribe => Package[$::nfs::params::bind_packages],
    }

    if $manage_firewall {
	    ::iptables::tcp_port {
	        'sunrpc': port => '111';
		}
    }

    file { '/etc/sysconfig/rpcbind':
        content => template('nfs/rpcbind'),
    }

    service { $::nfs::params::bind_service:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
