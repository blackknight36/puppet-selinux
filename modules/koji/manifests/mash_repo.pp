# modules/koji/manifests/mash_repo.pp
#
# Synopsis:
#       Installs a mash_repo configuration file for Koji's mash client.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
#       source                  URI of file content
#
# Notes:
#
#       1. Default is 'present'.
#
# Requires:
#       Class['koji::mash']


define koji::mash_repo ($ensure='present', $source) {

    include 'koji::params'

    file { "$koji::params::our_mashes/${name}.mash":
        ensure      => $ensure,
        owner       => 'root',
        group       => 'root',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        require     => Class['koji::mash'],
        subscribe   => Package[$koji::params::mash_packages],
        source      => $source,
    }

}
