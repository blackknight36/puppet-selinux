# modules/bacula/manifests/common.pp
#
# == Class: jaf_bacula::common
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


class jaf_bacula::common {

    include 'jaf_bacula::params'

    package { $jaf_bacula::params::common_packages:
        ensure  => installed,
    }

}
