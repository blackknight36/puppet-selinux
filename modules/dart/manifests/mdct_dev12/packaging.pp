# modules/dart/manifests/mdct_dev12/packaging.pp
#
# == Class: dart::mdct_dev12::packaging
#
# Manages software packaging features on John Florian's workstation.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_dev12::packaging {

    include '::dart::subsys::koji::cli'
    include '::dart::subsys::sigul::params'

    ::sigul::client_config { '/etc/sigul/client.conf':
        bridge_hostname => $::dart::subsys::sigul::params::bridge_hostname,
        server_hostname => $::dart::subsys::sigul::params::server_hostname,
    }

}
