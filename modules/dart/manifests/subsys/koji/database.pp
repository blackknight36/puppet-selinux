# modules/dart/manifests/subsys/koji/database.pp
#
# == Class: dart::subsys::koji::database
#
# Manages the Koji database.
#
# === Upgrading
#
# See documentation in koji::database.
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


class dart::subsys::koji::database inherits ::dart::subsys::koji::params {

    class { '::koji::database':
        username         => $::dart::subsys::koji::params::db_user,
        password         => $::dart::subsys::koji::params::db_passwd,
        schema_source    => '/usr/share/doc/koji/docs/schema.sql',
        listen_addresses => '*',
    }

}
