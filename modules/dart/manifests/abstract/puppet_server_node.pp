# modules/dart/manifests/abstract/puppet_server_node.pp

class dart::abstract::puppet_server_node inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'
    include 'packages::developer'

    class { 'puppet::client':
    }

    class { 'puppet::foreman':
        foreman_url => 'http://10.1.250.106:3000/',
    }

    class { 'puppet::server':
        use_passenger   => false,
        cert_name       => "$fqdn",
    }

    class { 'puppet::tools':
        cron_cleanup    => 'puppet:///private-host/puppet/puppet-report-cleanup.cron',
        tools_conf      => 'puppet:///private-host/puppet/puppet-tools.conf',
    }

    include 'dart::subsys::yum_cron'

    sendmail::alias { 'puppet':
        recipient   => 'root',
    }

    sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

}
