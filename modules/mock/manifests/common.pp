# modules/mock/manifests/common.pp
#
# Synopsis:
#       Configures a host as a mock common.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       NONE
#
# Notes:
#       NONE


class mock::common {

    include 'mock::params'

    package { $mock::params::packages:
        ensure  => installed,
    }

}
