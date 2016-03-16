# modules/dart/manifests/mdct_dev27_puppetboard.pp
#
# Synopsis:
#       puppetboard server
#
# Contact:
#       Michael Watters

class dart::mdct_dev27_puppetboard {

    include 'dart::abstract::puppetboard_server_node'
    include 'collectd::client'

}
