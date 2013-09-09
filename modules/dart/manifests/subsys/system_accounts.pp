# modules/dart/manifests/subsys/system_accounts.pp
#
# Synopsis:
#       Global identity support for system accounts.
#
# Description/Rationale:
#       There are often cases where a system account is needs to be shared
#       across several hosts.  A directory server (LDAP, NIS, etc.) might be
#       one way, but this can often lead to a Catch-22 situation where some
#       resource will require the identity before proper networked identity
#       support is brought up.  Local identities eliminate this Catch-22, but
#       ordinarily would be difficult to manage in a global sense.  Puppet
#       effectively eliminates that difficulty and this class aims to simply
#       solve all the problems described above.
#
#       All such identities for Dart systems are defined here in this one
#       class to simplify the task of gaining awareness of what UID/GID values
#       have been defined and what are likely available.


class dart::subsys::system_accounts {

    # MAINTENANCE PROTOCOL:
    #   1. Keep group accounts and user accounts separated.
    #   2. Keep group/user accounts in gid/uid numerically sorted order.
    #   3. Looking for a free uid?  Try the following on several prominent
    #   hosts:
    #       getent passwd {300..499}
    #   4. Looking for a free gid?  Try the following on several prominent
    #   hosts:
    #       getent group {300..499}
    #

    #
    # GROUP ACCOUNTS
    #

    group { 'teamcity':
        gid     => 300,
        #system  => true,
    }

    #
    # USER ACCOUNTS
    #

    user { 'teamcity':
        comment     => 'TeamCity continuous integration operator',
        gid         => 300,
        home        => '/home/00/teamcity', # primarily has SSH keys for git
        password    => '!',
        require     => Group['teamcity'],
        uid         => 300,
    }

}
