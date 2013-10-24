# modules/koji/manifests/mash.pp
#
# Synopsis:
#       Configures a host as a Koji mash client.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       hub                     URL of your Koji-Hub server
#
#       top_dir                 directory containing the repos/ directory


class koji::mash ( $hub, $top_dir ) {

    include 'koji::params'

    package { $koji::params::mash_packages:
        ensure  => installed,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$koji::params::mash_packages],
    }

    file { '/etc/mash/mash.conf':
        content => template('koji/mash/mash.conf'),
    }

    file { "$koji::params::our_mashes":
        ensure  => directory,
        mode    => '0755',
    }

}
