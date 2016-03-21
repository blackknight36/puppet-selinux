# == Class: openssl::ca_certificate
#
# Adds a CA certificate to the OpenSSL trust store
#
# === Parameters
#
# ==== Required
#
# [*name*]
#   Name to store the certificate as.
#
# ==== Optional
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*source*]
#   Certificate source, either an absolute path on the host
#   or a puppet file reference
#
# [*content*]
#   Certificate content
#
# === Usage
#
# Install the puppet CA certificate
#
#    openssl::ca_certificate { 'puppet-ca':
#      source => '/var/lib/puppet/ssl/certs/ca.pem',
#    }
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#   Michael Watters <michael.watters@dart.biz>
#
# === Copyright
#
# Copyright 2016 Dart Container


define openssl::ca_certificate (
        $ensure = 'present',
        $source = undef,
        $content = undef,
        ) {

    include '::openssl::params'

    $ca_cert_path = "/etc/pki/ca-trust/source/anchors/${name}.crt"

    file { $ca_cert_path:
        ensure    => $ensure,
        owner     => 'root',
        group     => 'root',
        mode      => '0444',
        source    => $source,
        content   => $content,
        subscribe => Package[$::openssl::params::packages],
    }

    # Establish a link to the traditional location since many other services
    # (e.g., openldap, sssd) expect it there.
    $link_ensure = $ensure ? {
        'absent' => 'absent',
        default  => link,
    }

    file { "/etc/pki/tls/certs/${name}.crt":
        ensure  => $link_ensure,
        target  => $ca_cert_path,
        require => File[$ca_cert_path],
    } ~>

    exec { "update-ca-trust ${name}":
        command     => '/bin/update-ca-trust',
        unless      => "stat ${ca_cert_path}",
        refreshonly => true,
    }

}
