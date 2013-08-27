# modules/dart/manifests/abstract/puppet_server_node.pp

class dart::abstract::puppet_server_node inherits dart::abstract::guarded_server_node {

    include 'autofs'
    include 'packages::developer'

    class { 'puppet::client':
    }

    include 'puppet::server'
    include 'dart::subsys::yum_cron'

    mailalias { 'puppet':
        ensure          => present,
        recipient       => 'root',
    }

    mailalias { 'root':
        ensure          => present,
        recipient       => 'john.florian@dart.biz',
    }

}
