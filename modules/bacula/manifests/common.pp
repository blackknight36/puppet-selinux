# modules/bacula/manifests/common.pp
#
# == Class: bacula::common
#
# Configures the common parts of Bacula.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class bacula::common {

    include 'bacula::params'

    package { $bacula::params::common_packages:
        ensure  => installed,
    }

}
