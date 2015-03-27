# modules/koji/manifests/ca.pp
#
# == Class: koji::ca
#
# Manages the Koji SSL Certificate Authority (CA) on a host.
#
# This class will establish a Certificate Authority for the entire Koji
# infrastructure where x509 Certificates are used to identify and authenticate
# clients to services and vice-versa.  The result of this class will be said
# CA, its private key, public certificate, related control files and a shell
# script (certgen.sh) that facilitates simple creation of key/certificate pairs
# for both users and services.
#
# Once this class has been applied, you should be able to (as root):
#
#       cd /etc/pki/Koji
#       ./certgen.sh -h
#
# === Parameters
#
# ==== Required
#
# [*country*]
#   Default value for Country Name (2 letter code) in any certificates created
#   by this CA.
#
# [*state*]
#   Default value for State or Province Name in any certificates created by
#   this CA.
#
# [*locality*]
#   Default value for Locality Name in any certificates created by this CA.
#
# [*organization*]
#   Default value for Organization Name in any certificates created by this
#   CA.
#
# [*nfs_home*]
#   Name of NFS server where home directories are located.  This is required
#   to pre-configure the certgen.sh script for deploying certificates for each
#   user.
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class koji::ca (
        $country,
        $state,
        $locality,
        $organization,
        $nfs_home,
    ) {

    include '::koji::params'

    $admin_user = $::koji::params::admin_user
    $ca_name = 'Koji'
    $ca_root = "/etc/pki/${ca_name}"
    $ca_key = "${ca_root}/private/${ca_name}_ca_cert.key"
    $ca_cert = "${ca_root}/certs/${ca_name}_ca_cert.crt"
    $ca_gen_cnf = "${ca_root}/confs/cacertgen.cnf"

    File {
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'cert_t',
        before  => Exec['create_ca_key'],
    }

    Exec {
        cwd => $ca_root,
    }

    file { $ca_root:
        ensure => directory,
        mode   => '0755',
    }

    file { ["${ca_root}/certs", "${ca_root}/private", "${ca_root}/confs", ]:
        ensure  => directory,
        mode    => '0755',
        require => File[$ca_root],
    }

    file { "${ca_root}/certgen.sh":
        mode    => '0754',
        require => File[$ca_root],
        content => template('koji/ca/certgen.sh'),
    }

    file { "${ca_root}/ssl.cnf":
        require => File[$ca_root],
        content => template('koji/ca/ssl.cnf'),
    }

    file { "${ca_root}/index.txt":
        ensure  => present,
        require => File[$ca_root],
    }

    file { "${ca_root}/serial":
        require => File[$ca_root],
        content => "01\n",  # double-quotes req'd for interpolation
        replace => false,
    }

    exec { 'create_ca_key':
        command => "openssl genrsa -out ${ca_key} 2048",
        creates => $ca_key,
    }

    exec { 'create_ca_cert':
        command => "openssl req -config ssl.cnf -new -x509 -subj \"/C=${country}/ST=${state}/L=${locality}/O=Dart Container Corp./OU=${ca_name} Certificate Authority/CN=${::fqdn}\" -days 3650 -key ${ca_key} -out ${ca_cert} -extensions v3_ca",
        creates => $ca_cert,
        require => Exec['create_ca_key'],
    }

}
