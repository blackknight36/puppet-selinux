# modules/bacula/manifests/dir_sd_common.pp
#
# Synopsis:
#       Configures the common parts of Bacula as needed on Directors and
#       Storage Daemons.
#
# Parameters:
#       NONE
#
# Requires:
#       NONE

class bacula::dir_sd_common {

    include 'bacula::params'

    package { $bacula::params::dir_sd_common_packages:
        ensure  => installed,
    }

}
