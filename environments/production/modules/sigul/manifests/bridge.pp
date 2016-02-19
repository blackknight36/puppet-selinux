# modules/sigul/manifests/bridge.pp
#
# == Class: sigul::bridge
#
# Manages a host as a Sigul Bridge to relay requests between clients and the
# Sigul Server.
#
# === Parameters
#
# ==== Required
#
# [*client_cert*]
#   Puppet source URI providing the Koji-Web component's identity certificate
#   which must be in PEM format.
#
# [*ca_cert*]
#   Puppet source URI providing the CA certificate that signed "client_cert".
#
# [*hub_ca_cert*]
#   Puppet source URI providing the CA certificate that signed the Koji-Hub
#   certificate.
#
# [*hub*]
#   URL of your Koji-Hub server.
#
# [*web*]
#   URL of your Koji-Web server.
#
# [*downloads*]
#   URL of your Koji package download site.
#
# [*nss_password*]
#   Password used to protect the NSS certificate database.
#
# [*top_dir*]
#   Directory containing Koji's "repos/" directory.
#
# ==== Optional
#
# [*enable*]
#   Instance is to be started at boot.  Either true (default) or false.
#
# [*ensure*]
#   Instance is to be 'running' (default) or 'stopped'.
#
# [*koji_dir*]
#   Directory that is to contain the Koji integration files: configuration,
#   certificates, keys, etc.  Defaults to "/var/lib/sigul/.koji".
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class sigul::bridge (
        $client_cert,
        $ca_cert,
        $hub_ca_cert,
        $downloads,
        $hub,
        $nss_password,
        $top_dir,
        $web,
        $enable=true,
        $ensure='running',
        $koji_dir='/var/lib/sigul/.koji',
    ) inherits ::sigul::params {

    include '::sigul'

    File {
        owner     => 'sigul',
        group     => 'sigul',
        mode      => '0640',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        before    => Service[$::sigul::params::bridge_services],
        notify    => Service[$::sigul::params::bridge_services],
        subscribe => Package[$::sigul::params::packages],
    }

    file {
        '/etc/sigul/bridge.conf':
            owner   => 'root',
            content => template('sigul/bridge.conf'),
            ;

        $koji_dir:
            ensure => directory,
            mode   => '0750',
            ;

        "${koji_dir}/config":
            content => template('sigul/koji.conf'),
            ;

        "${koji_dir}/client.crt":
            source  => $client_cert,
            ;

        "${koji_dir}/clientca.crt":
            source  => $ca_cert,
            ;

        "${koji_dir}/serverca.crt":
            source  => $hub_ca_cert,
            ;
    }

    iptables::tcp_port {
        'sigul_clients':    port => '44334';
        'sigul_server':     port => '44333';
    }

    service { $::sigul::params::bridge_services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
        subscribe  => Package[$::sigul::params::packages],
    }

}
