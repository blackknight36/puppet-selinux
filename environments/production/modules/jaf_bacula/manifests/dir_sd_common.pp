# modules/bacula/manifests/dir_sd_common.pp
#
# == Class: jaf_bacula::dir_sd_common
#
# Configures the parts of Bacula common to both Directors and Storage Daemons.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class jaf_bacula::dir_sd_common {

    include 'jaf_bacula::params'

    package { $jaf_bacula::params::dir_sd_common_packages:
        ensure  => installed,
    }

}
