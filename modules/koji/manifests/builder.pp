# modules/koji/manifests/builder.pp
#
# == Class: koji::builder
#
# Manages a host as a Koji Builder.
#
# === Parameters
#
# ==== Required
#
# [*client_cert*]
#   Puppet source URI providing the builder's identity certificate which must
#   be in PEM format.
#
# [*ca_cert*]
#   Puppet source URI providing the CA certificate that signed "client_cert".
#
# [*web_ca_cert*]
#   Puppet source URI providing the CA certificate that signed the Koji-Web
#   certificate.
#
# [*hub*]
#   URL of your Koji-Hub service.
#
# [*downloads*]
#   URL of your package download site.
#
# [*top_dir*]
#   Name of the directory containing the "repos/" directory.
#
# ==== Optional
#
# [*debug*]
#   Enable verbose debugging for the Koji Builder.
#   One of: true or false (default).
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


class koji::builder (
        $client_cert,
        $ca_cert,
        $web_ca_cert,
        $hub,
        $downloads,
        $top_dir,
        $debug=false,
        $enable=true,
        $ensure='running',
    ) inherits ::koji::params {

    validate_bool($debug)

    package { $::koji::params::builder_packages:
        ensure => installed,
        notify => Service[$::koji::params::builder_services],
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        before    => Service[$::koji::params::builder_services],
        notify    => Service[$::koji::params::builder_services],
        subscribe => Package[$::koji::params::builder_packages],
    }

    file {
        '/etc/kojid/kojid.conf':
            content => template('koji/builder/kojid.conf');

        '/etc/sysconfig/kojid':
            content => template('koji/builder/kojid');

        '/etc/kojid/client.pem':
            source  => $client_cert;

        '/etc/kojid/clientca.crt':
            source  => $ca_cert;

        '/etc/kojid/serverca.crt':
            source  => $web_ca_cert;
    }

    service { $::koji::params::builder_services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
