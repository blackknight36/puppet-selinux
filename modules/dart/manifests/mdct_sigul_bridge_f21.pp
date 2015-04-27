# modules/dart/manifests/mdct_sigul_bridge_f21.pp
#
# == Class: dart::mdct_sigul_bridge_f21
#
# Manages a Dart host as a bridge to our Sigul server.
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


class dart::mdct_sigul_bridge_f21 inherits ::dart::abstract::sigul_node {

    include '::dart::subsys::koji::params'

    network::interface { 'eth0':
        template   => 'static',
        ip_address => '10.1.192.138',
        netmask    => '255.255.0.0',
        gateway    => '10.1.0.25',
        stp        => 'no',
    }

    class { '::sigul::bridge':
        client_cert  => "puppet:///modules/dart/koji/kojiweb-on-${::dart::subsys::koji::params::web_host}.pem",
        ca_cert      => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        hub_ca_cert  => 'puppet:///modules/dart/koji/Koji_ca_cert.crt',
        downloads    => $::dart::subsys::koji::params::downloads,
        hub          => $::dart::subsys::koji::params::hub,
        nss_password => $::dart::subsys::sigul::params::nss_password,
        top_dir      => $::dart::subsys::koji::params::topdir,
        web          => "http://${::fqdn}/koji",
    }

}
