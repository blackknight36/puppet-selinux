# modules/dart/manifests/abstract/puppet_server_node.pp
#
# == Class: dart::abstract::puppet_server_node
#
# Manages a Dart host as a Puppet Server node.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   Michael Watters <michael.watters@dart.biz>


class dart::abstract::puppet_server_node inherits ::dart::abstract::guarded_server_node {

    include '::dart::abstract::packages::developer'
    include '::dart::subsys::autofs::common'

    class { '::hiera':
        source => 'puppet:///modules/dart/hiera/hiera.yaml',
    }

    class { '::puppet::server':
        use_passenger => false,
        use_puppetdb  => false,
        cert_name     => $::fqdn,
    }

    class { '::puppet::tools':
        conf_content => 'dart/puppet/tools/puppet-tools.conf.erb',
        cron_source  => 'puppet:///modules/dart/puppet/tools/puppet-tools.cron',
        lint_source  => 'puppet:///modules/dart/puppet/tools/puppet-lint.rc',
    }

    include '::dart::subsys::yum_cron'

    ::sendmail::alias { 'puppet':
        recipient => 'root',
    }

    ::sendmail::alias { 'root':
        recipient => 'john.florian@dart.biz',
    }

}
