# modules/apache/manifests/mod_wsgi.pp
#
# == Class: apache::mod_wsgi
#
# Configures the Apache web server to provide mod_wsgi (python) support.
#
# === Parameters
#
# [*manage_firewall*]
#   If true, open the HTTPS port on the firewall.  Otherwise the firewall is
#   left unaffected.  Defaults to true.
#
# === Authors
#
#   Michael Watters <michael.watters@dart.biz>


class apache::mod_wsgi {

    package { $apache::params::modwsgi_packages:
        ensure => installed,
        notify => Service[$apache::params::services],
    }

}
