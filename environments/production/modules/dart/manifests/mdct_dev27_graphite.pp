class dart::mdct_dev27_graphite inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::yum::rpmfusion'

    class {'collectd::server':} -> 

    class {'graphite':}

}
