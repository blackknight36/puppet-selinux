# modules/openssl/manifests/ca_certificate/dart.pp
#
# == Class: openssl::ca_certificate::dart
#
# Installs the CA bundle for Dart certificates.
#
# === Authors
#
# Michael Watters <michael.watters@dart.biz>

class openssl::ca_certificate::dart() {

    openssl::ca_certificate { 'dart_ca':
        source => 'puppet:///modules/openssl/dart_ca.pem',
    }

}

