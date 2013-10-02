# modules/postgresql/manifests/config.pp
#
# Synopsis:
#       Installs a PostgreSQL Server configuration file.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
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


define postgresql::config ($ensure='present', $source) {

    include 'postgresql::params'

    file { "/var/lib/pgsql/data/${name}":
        ensure      => $ensure,
        owner       => 'postgres',
        group       => 'postgres',
        mode        => '0600',
        seluser     => 'unconfined_u',
        selrole     => 'object_r',
        seltype     => 'postgresql_db_t',
        before      => Service[$postgresql::params::service_name],
        notify      => Service[$postgresql::params::service_name],
        subscribe   => Package[$postgresql::params::server_packages],
        source      => $source,
    }

}
