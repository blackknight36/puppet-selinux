# modules/dart/manifests/abstract/tomcat_web_app.pp

class dart::abstract::tomcat_web_app inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'

    class { 'postgresql::server':
        hba_conf    => 'puppet:///private-host/postgresql/pg_hba.conf',
    }

    # puppet::client is included this way to prevent duplicate declaration
    # arising out of dart::abstract::teamcity_server_node.  This works only
    # because the default class params are acceptable here.
    include 'puppet::client'

    package { [ 'tomcat6', 'tomcat6-admin-webapps', ]:
        ensure  => installed,
    }

    iptables::tcp_port {
        'tomcat_web_app': port => '8080';
    }

}
