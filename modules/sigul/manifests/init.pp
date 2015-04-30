# modules/sigul/manifests/init.pp
#
# == Class: sigul
#
# Manages resources common to all usages of Sigul be it Client, Bridge or
# Server.
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


class sigul inherits ::sigul::params {

    package { $::sigul::params::packages:
        ensure => installed,
    }

}
