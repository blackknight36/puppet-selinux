class dart::mdct_dev27_graphite inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::yum::rpmfusion'

    class {'apache':
        network_connect => true,
        server_admin => 'michael.watters@dart.biz',
    } ->

    class {'graphite':} ->

    class {'collectd::server':}

}
