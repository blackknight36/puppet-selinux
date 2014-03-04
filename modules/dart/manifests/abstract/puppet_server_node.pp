# modules/dart/manifests/abstract/puppet_server_node.pp

class dart::abstract::puppet_server_node inherits dart::abstract::guarded_server_node {

    include 'dart::subsys::autofs::common'
    include 'packages::developer'

    class { 'puppet::client':
    }

    class { 'puppet::foreman':
        foreman_url => 'http://10.1.250.106:3000/',
    }

    include 'puppet::server'
    include 'dart::subsys::yum_cron'

    sendmail::alias { 'puppet':
        recipient   => 'root',
    }

    sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

}
