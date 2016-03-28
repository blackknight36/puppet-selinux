# modules/apache/manifests/mod_wsgi.pp
#
# == Class: apache::mod_wsgi
#
# Configures the Apache web server to provide mod_wsgi (python) support.
#
# === Parameters
#
# === Authors
#
#   Michael Watters <michael.watters@dart.biz>


class apache::mod_wsgi inherits apache::params {

    package { $apache::params::modwsgi_packages:
        ensure => installed,
        notify => Service[$apache::params::services],
    }

}
