# modules/mock/manifests/user.pp
#
# Synopsis:
#       Configures a host to make some user a member of the mock group.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       name                    user whom is to be a member of the mock group
#
#       ensure          1       instance is to be present/absent
#
# Notes:
#
#       1. Default is 'present'.


define mock::user ($ensure='present') {

    include 'mock::common'
    include 'mock::params'

    case $ensure {
        'present': {
            # NB: Puppet's 'user' type not used here because we want to support
            # incremental additions to the mock group through multiple uses of this
            # definition.
            #
            # NB: 'getent' is used instead of 'groups' because the latter requires
            # a new login environment before the addition is realized.
            exec { "add-${name}-to-mock-group":
                command => "usermod -a -G mock ${name}",
                unless  => "getent group mock | cut -d: -f4- | sed 's/,/\\n/g' | grep '^${name}$'",
                require => Class['mock::common'],
                logoutput   => true,
            }
        }

        default: {
            fail ("mock::user does not yet support 'ensure => ${ensure}'")
        }

    }

}
