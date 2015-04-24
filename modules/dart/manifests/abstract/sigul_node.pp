# modules/dart/manifests/abstract/sigul_node.pp
#
# == Class: dart::abstract::sigul_node
#
# Manages a Dart host as an abstract Sigul node.
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


class dart::abstract::sigul_node inherits ::dart::abstract::guarded_server_node {

    include '::dart::subsys::sigul::params'

    class { '::network':
        service      => 'nm',
        domain       => $dart::params::dns_domain,
        name_servers => $dart::params::dns_servers,
    }

    ::sendmail::alias { 'root':
        recipient   => $::dart::subsys::sigul::params::root_email_recipient,
    }

}
