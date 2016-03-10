# modules/dart/manifests/subsys/koji/cli.pp
#
# == Class: dart::subsys::koji::cli
#
# Manages the Koji CLI.
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


class dart::subsys::koji::cli inherits ::dart::subsys::koji::params {

    include '::dart::subsys::koji::autofs'

    class { '::koji::cli':
        hub       => $::dart::subsys::koji::params::hub,
        web       => "http://${::dart::subsys::koji::params::web_host}/koji",
        downloads => $::dart::subsys::koji::params::downloads,
        top_dir   => $::dart::subsys::koji::params::topdir,
        require   => Class['::dart::subsys::koji::autofs'],
    }

}
