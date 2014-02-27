# modules/dart/manifests/mdct_nexus.pp
#
# Synopsis:
#       Sonatype Nexus server for Maven builds.
#
# Contact:
#       Levi Harper

class dart::mdct_nexus inherits dart::abstract::guarded_server_node {

    include 'apache'

    class { 'puppet::client':
    }

    class { 'bacula::client':
        dir_passwd      => 'v1OUZExhC5RwX6VtphBlrD61PI1XrlwVZH7yMFCVy1Yj',
        mon_passwd      => 'rlgfP6nL1RbmTV7MiSJqOPSEp5Uh06J5aeon9fOk93i1',
    }

    # This package allows optimal performance in production environments.
    package { 'tomcat-native':
        ensure  => installed,
    }

}
