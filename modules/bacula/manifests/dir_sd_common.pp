# modules/bacula/manifests/dir_sd_common.pp
#
# == Class: bacula::dir_sd_common
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


class bacula::dir_sd_common {

    include 'bacula::params'

    package { $bacula::params::dir_sd_common_packages:
        ensure  => installed,
    }

}
