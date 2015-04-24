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

    network::interface { 'eth0':
        template   => 'static',
        ip_address => '10.1.192.138',
        netmask    => '255.255.0.0',
        gateway    => '10.1.0.25',
        stp        => 'no',
    }

    class { '::sigul::bridge':
        nss_password => $::dart::subsys::sigul::params::nss_password,
    }

}
