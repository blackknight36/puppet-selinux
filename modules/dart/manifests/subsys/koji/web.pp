# modules/dart/manifests/subsys/koji/web.pp
#
# == Class: dart::subsys::koji::web
#
# Manages the Koji Web component.
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


class dart::subsys::koji::web inherits ::dart::subsys::koji::params {

    class { '::koji::web':
        client_cert  => "puppet:///modules/dart/koji/kojiweb-on-${::fqdn}.pem",
        ca_cert      => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        hub_ca_cert  => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        secret       => $dart::subsys::koji::params::web_passwd,
        theme        => 'fedora-koji',
        theme_source => 'puppet:///modules/dart/koji/fedora-koji-theme.tgz',
    }

}
