# modules/apache/manifests/mod_ssl.pp
#
# == Class: apache::mod_ssl
#
# Configures the Apache web server to provide mod_ssl (HTTPS) support.
#
# === Parameters
#
# [*manage_firewall*]
#   If true, open the HTTPS port on the firewall.  Otherwise the firewall is
#   left unaffected.  Defaults to true.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class apache::mod_ssl (
        $manage_firewall=true,
    ) {

    package { $apache::params::modssl_packages:
        ensure => installed,
        notify => Service[$apache::params::services],
    }

    if $manage_firewall {
        iptables::tcp_port {
            'https':    port => '443';
        }
    }

}
