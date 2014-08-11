# modules/lyx/manifests/init.pp
#
# == Class: lyx
#
# Configures a host to offer lyx.
#
# === Parameters
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class lyx (
        $ensure='present',
    ) {

    include 'lyx::params'

    package { $lyx::params::packages:
        ensure  => $ensure,
    }

}
