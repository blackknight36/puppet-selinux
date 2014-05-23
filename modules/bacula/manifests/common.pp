# modules/bacula/manifests/common.pp
#
# Synopsis:
#       Configures the common parts of Bacula.
#
# Parameters:
#       NONE
#
# Requires:
#       NONE

class bacula::common {

    include 'bacula::params'

    package { $bacula::params::common_packages:
        ensure  => installed,
    }

}
