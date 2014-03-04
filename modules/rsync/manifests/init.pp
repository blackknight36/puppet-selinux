# modules/rsync/manifests/init.pp
#
# == Class: rsync
#
# Configures a host for rsync use.
#
# === Parameters
#
# [*ensure*]
#   Instance is to be 'installed' (default), 'latest' or 'absent'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class rsync ($ensure='installed') {

    include 'rsync::params'

    package { $rsync::params::packages:
        ensure  => $ensure
    }

}
