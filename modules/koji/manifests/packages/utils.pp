# modules/koji/manifests/packages/utils.pp
#
# == Class: koji::packages::utils
#
# Manages the Koji utilities package.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*ensure*]
#   Identical to the ensure parameter of the standard File resource type.
#   The default is 'present'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class koji::packages::utils (
        $ensure='present',
    ) inherits ::koji::params {

    package { $::koji::params::utils_packages:
        ensure => $ensure,
    }

}
