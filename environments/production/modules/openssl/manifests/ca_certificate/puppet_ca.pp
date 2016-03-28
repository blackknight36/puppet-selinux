# modules/openssl/manifests/ca_certificate/puppet_ca.pp
#
# == Class: openssl::ca_certificate::puppet
#
# Installs the CA bundle for Dart certificates.
#
# === Authors
#
# Michael Watters <michael.watters@puppet.biz>

class openssl::ca_certificate::puppet_ca() {

    openssl::ca_certificate { 'puppet_ca':
        source => "${puppet::params::puppet_ssl_dir}/certs/ca.pem",
    }

}

