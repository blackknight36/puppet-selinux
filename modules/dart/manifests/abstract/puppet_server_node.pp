# modules/dart/manifests/abstract/puppet_server_node.pp

class dart::abstract::puppet_server_node inherits dart::abstract::server_node {

    include 'packages::developer'
    include 'puppet::server'
    include 'yum-cron'

    mailalias { 'puppet':
        ensure          => present,
        recipient       => 'root',
    }

    mailalias { 'root':
        ensure          => present,
        recipient       => 'john.florian@dart.biz',
    }

}
