# modules/dart/manifests/mdct_fogbugz.pp
#
# Synopsis:
#       Fogbugz
#
# Contact:
#       Levi Harper

class dart::mdct_fogbugz inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'

    class { 'mariadb::server':
    }

    class { 'puppet::client':
    }

    class { 'apache':
        network_connect => true,
    }

    class { 'bacula::client':
        dir_name    => $dart::params::bacula_dir_name,
        mon_name    => $dart::params::bacula_mon_name,
        dir_passwd      => '0dec843864c41aa0a93e87c44d262e19',
        mon_passwd      => 'rlgfP6nL1RbmTV7MiSJqOPSEp5Uh06J5aeon9fOk93i1',
    }

}