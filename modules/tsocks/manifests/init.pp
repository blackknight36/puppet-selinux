# modules/tsocks/manifests/init.pp
#
# == Class: tsocks
#
# Manages tsocks on a host.
#
# === Parameters
#
# ==== Required
#
# [*local_networks*]
#   An array of IP/Subnet pairs, each specifying a network which may be
#   accessed directly without proxying through a SOCKS server, e.g.,
#   ['10.0.0.0/255.0.0.0'].  Obviously all SOCKS server IP addresses must be
#   in networks specified as local, otherwise tsocks would need a SOCKS server
#   to reach SOCKS servers.
#
# [*proxy_server*]
#   The IP address of the SOCKS server, e.g., '10.1.4.253'.
#
# ==== Optional
#
# [*server_type*]
#   SOCKS version used by the server.  Versions 4 and 5 are supported (but
#   both for only the connect operation).  The default is '4'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class tsocks (
        $local_networks,
        $proxy_server,
        $server_type='4',
    ) inherits ::tsocks::params {

    package { $::tsocks::params::packages:
        ensure => installed,
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::tsocks::params::packages],
    }

    file { '/etc/tsocks.conf':
        content => template('tsocks/tsocks.conf.erb'),
    }

}
