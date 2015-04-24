# modules/sigul/manifests/server.pp
#
# == Class: sigul::server
#
# Manages a host as a Sigul Server.
#
# For security reasons the Sigul Server should be highly isolated and only
# reachable via the Sigul Bridge.
#
# === Parameters
#
# ==== Required
#
# [*bridge_hostname*]
#   The hostname of your Sigul Bridge that will relay requests to this server.
#
# [*nss_password*]
#   Password used to protect the NSS certificate database.
#
# ==== Optional
#
# [*database_path*]
#   Filesystem path to the server's SQLite database.  Defaults to
#   '/var/lib/sigul/server.sqlite'.
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


class sigul::server (
        $bridge_hostname,
        $nss_password,
        $database_path='/var/lib/sigul/server.sqlite',
        $enable=true,
        $ensure='running',
    ) inherits ::sigul::params {

    File {
        owner     => 'root',
        group     => 'sigul',
        mode      => '0640',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        before    => Service[$::sigul::params::server_services],
        notify    => Service[$::sigul::params::server_services],
        subscribe => Package[$::sigul::params::packages],
    }

    package { $::sigul::params::packages:
        ensure => installed,
        notify => Service[$::sigul::params::server_services],
    } ->

    exec { 'sigul_server_create_db':
        creates => $database_path,
        notify  => File[$database_path],
    } ->

    file {
        '/etc/sigul/server.conf':
            content => template('sigul/server.conf'),
            ;

        $database_path:
            owner   => 'sigul',
            mode    => '0600',
            seltype => 'var_lib_t',
            ;
    }

    service { $::sigul::params::server_services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
