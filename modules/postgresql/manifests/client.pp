# modules/postgresql/manifests/client.pp
#
# == Class: postgresql::client
#
# Configures a host as a PostgreSQL client.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class postgresql::client {

    include 'postgresql::params'

    package { $postgresql::params::client_packages:
        ensure  => installed,
    }

}
