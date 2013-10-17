# modules/koji/manifests/builder.pp
#
# Synopsis:
#       Configures a host as a Koji Builder.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       client_cert             URI of builder's identity certificate
#
#       ca_cert                 URI of CA certificate that signed client_cert
#
#       web_ca_cert             URI of CA certificate that signed the HTTP cert
#
#       hub                     URL of your Koji-Hub server
#
#       downloads               URL of your package download site
#
#       top_dir                 directory containing the repos/ directory


class koji::builder (
        $client_cert, $ca_cert, $web_ca_cert,
        $hub, $downloads, $top_dir
    ) {

    include 'koji::params'

    package { $koji::params::builder_packages:
        ensure  => installed,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$koji::params::builder_service_name],
        notify      => Service[$koji::params::builder_service_name],
        subscribe   => Package[$koji::params::builder_packages],
    }

    file { '/etc/kojid/kojid.conf':
        content => template('koji/builder/kojid.conf'),
    }

    file { '/etc/kojid/client.crt':
        source  => "${client_cert}",
    }

    file { '/etc/kojid/clientca.crt':
        source  => "${ca_cert}",
    }

    file { '/etc/kojid/serverca.crt':
        source  => "${web_ca_cert}",
    }

    service { $koji::params::builder_service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
