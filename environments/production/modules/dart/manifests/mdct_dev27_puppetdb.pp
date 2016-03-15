# modules/dart/manifests/mdct_dev27_puppetdb.pp
#
# Synopsis:
#       puppetdb server
#
# Contact:
#       Michael Watters

class dart::mdct_dev27_puppetdb inherits dart::abstract::guarded_server_node {

    include 'puppet::database'

    include 'collectd::client'

    package { [ 'mc' ]:
        ensure => latest,
    }

}
