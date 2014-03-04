# modules/dart/manifests/mdct_foreman.pp
#
# Synopsis:
#       Foreman server for Puppet node management.
#
# Contact:
#       Levi Harper/John Florian

class dart::mdct_foreman inherits dart::abstract::guarded_server_node {

    include 'apache'

    class { 'puppet::client':
    }

    class { 'postgresql::server':
        hba_conf    => 'puppet:///private-host/postgresql/pg_hba.conf',
    }

}
