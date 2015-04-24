# modules/sigul/manifests/client.pp
#
# == Class: sigul::client
#
# Manages a host as a Sigul Client to submit requests through the Sigul Bridge
# into the Sigul Server.
#
# === Parameters
#
# ==== Required
#
# [*bridge_hostname*]
#   The hostname of your Sigul Bridge that will relay requests for this
#   client.
#
# [*server_hostname*]
#   The hostname of your Sigul Server that will process requests for this
#   client.
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class sigul::client (
        $bridge_hostname,
        $server_hostname,
    ) inherits ::sigul::params {

    package { $::sigul::params::packages:
        ensure => installed,
    }

    File {
        owner     => 'root',
        group     => 'sigul',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::sigul::params::packages],
    }

    file { '/etc/sigul/client.conf':
        content => template('sigul/client.conf'),
    }

}
