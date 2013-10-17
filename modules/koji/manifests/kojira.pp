# modules/koji/manifests/kojira.pp
#
# Synopsis:
#       Configures a host to provide Kojira.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       hub                     URL of your Koji-Hub server
#
#       top_dir                 directory containing the repos/ directory


class koji::kojira ( $hub, $top_dir ) {

    include 'koji::params'

    package { $koji::params::kojira_packages:
        ensure  => installed,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$koji::params::kojira_service_name],
        notify      => Service[$koji::params::kojira_service_name],
        subscribe   => Package[$koji::params::kojira_packages],
    }

    file { '/etc/kojira/kojira.conf':
        content => template('koji/kojira/kojira.conf'),
    }

    service { $koji::params::kojira_service_name:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
