# modules/koji/manifests/ca.pp
#
# Synopsis:
#       Configures a host to provide a SSL Certificate Authority for Koji.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       country                 default value for Country Name (2 letter code)
#
#       state                   default value for State or Province Name
#
#       locality                default value for Locality Name
#
#       organization            default value for Organization Name
#
# Description:
#       This class will establish a Certificate Authority for the entire Koji
#       infrastructure where x509 Certificates are used to identify and
#       authenticate clients to services and vice-versa.  The result of this
#       class will be said CA, its private key, public certificate, related
#       control files and a pair of shell scripts that facilitate simple
#       creation of key/certificate pairs for both users and services.


class koji::ca ( $country, $state, $locality, $organization ) {

    include 'koji::params'

    $ca_root = '/etc/pki/koji'
    $ca_key = "${ca_root}/private/koji_ca_cert.key"
    $ca_cert = "${ca_root}/koji_ca_cert.crt"
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
        cwd     => "${ca_root}",
    }

    file { "${ca_root}":
        ensure  => directory,
        mode    => '0755',
    }

    file { ["${ca_root}/certs", "${ca_root}/private", "${ca_root}/confs", ]:
        ensure  => directory,
        mode    => '0755',
        require => File["${ca_root}"],
    }

    file { "${ca_root}/certgen.sh":
        mode    => 0750,
        require => File["${ca_root}"],
        source  => 'puppet:///modules/koji/ca/certgen.sh',
    }

    file { "${ca_root}/ssl.cnf":
        require => File["${ca_root}"],
        content => template('koji/ca/ssl.cnf'),
    }

    file { "${ca_root}/index.txt":
        require => File["${ca_root}"],
        ensure  => present,
    }

    file { "${ca_root}/serial":
        require => File["${ca_root}"],
        content => "01\n",  # double-quotes req'd for interpolation
        replace => false,
    }

    exec { 'create_ca_key':
        command => "openssl genrsa -out ${ca_key} 2048",
        creates => "${ca_key}",
    }

    exec { 'create_ca_cert':
        command => "openssl req -config ssl.cnf -new -x509 -subj \"/C=${country}/ST=${state}/L=${locality}/O=Dart Container Corp./OU=Koji Certificate Authority/CN=${fqdn}\" -days 3650 -key ${ca_key} -out ${ca_cert} -extensions v3_ca",
        creates => "${ca_cert}",
        require => Exec['create_ca_key'],
    }

}
