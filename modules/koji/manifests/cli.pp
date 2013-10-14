# modules/koji/manifests/cli.pp
#
# Synopsis:
#       Configures a host to provide the koji CLI.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       hub                     URL of your Koji-Hub server
#
#       web                     URL of your Koji-Web server
#
#       downloads               URL of your package download site


class koji::cli ( $hub, $web, $downloads ) {

    include 'koji::params'

    package { $koji::params::cli_packages:
        ensure  => installed,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$koji::params::cli_packages],
    }

    file { '/etc/koji.conf':
        content => template('koji/cli/koji.conf'),
    }

}
