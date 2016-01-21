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
# === Dependencies
#   Module[yo61-logrotate] >= v1.3.0
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::subsys::koji::hub inherits ::dart::subsys::koji::params {

    class { '::koji::hub':
        db_host   => '127.0.0.1',
        db_user   => $::dart::subsys::koji::params::db_user,
        db_passwd => $::dart::subsys::koji::params::db_passwd,
        web_cn    => "CN=${::dart::subsys::koji::params::web_host},OU=kojiweb,O=Dart Container Corp.,ST=Michigan,C=US",
        top_dir   => $::dart::subsys::koji::params::topdir,
        debug     => $::dart::subsys::koji::params::debug,
        require   => [
            Class['::dart::subsys::koji::autofs'],
            Class['::koji::database'],
        ],
    }

    class { '::logrotate':
        config => {
            # This matches the defaults of httpd-2.4.16-1.fc21:
            dateext  => true,
            # These values vary from those same defaults:
            # Compression is needed, especially for the httpd logs which have
            # lots of activity from other Koji/Sigul components.
            compress => true,
        },
    }

}
