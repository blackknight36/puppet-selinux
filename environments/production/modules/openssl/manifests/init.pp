# modules/openssl/manifests/init.pp
#
# == Class: openssl
#
# This class provides methods to add certs to the openssl trust store
#
# === Authors
#
#   Michael Watters <michael.watters@dart.biz>

class openssl() {
    include 'openssl::params'

    package { $openssl::params::openssl_packages:
        ensure => latest,
    }
}
