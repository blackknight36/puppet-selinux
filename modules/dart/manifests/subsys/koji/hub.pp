# modules/dart/manifests/subsys/koji/hub.pp
#
# == Class: dart::subsys::koji::hub
#
# Manages the Koji Hub component.
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


class dart::subsys::koji::hub inherits ::dart::subsys::koji::params {

    class { '::koji::hub':
        db_host   => '127.0.0.1',
        db_user   => $::dart::subsys::koji::params::db_user,
        db_passwd => $::dart::subsys::koji::params::db_passwd,
        web_cn    => "CN=${::fqdn},OU=kojiweb,O=Dart Container Corp.,ST=Michigan,C=US",
        top_dir   => $::dart::subsys::koji::params::topdir,
        debug     => true,
        require   => [
            Class['::dart::subsys::koji::autofs'],
            Class['::koji::database'],
        ],
    }

}
