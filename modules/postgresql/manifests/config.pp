# modules/postgresql/manifests/config.pp
#
# == Define: postgresql::config
#
# Installs a PostgreSQL Server configuration file.
#
# === Parameters
#
# [*namevar*]
#   Instance name.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*content*]
#   Literal content for the config file.  One and only one of "content" or
#   "source" must be given.
#
# [*source*]
#   URI of the config file content.  One and only one of "content" or "source"
#   must be given.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


define postgresql::config (
        $ensure='present', $content=undef, $source=undef,
    ) {

    include 'postgresql::params'

    file { "/var/lib/pgsql/data/${name}":
        ensure  => $ensure,
        owner   => 'postgres',
        group   => 'postgres',
        mode    => '0600',
        seluser => 'unconfined_u',
        selrole => 'object_r',
        seltype => 'postgresql_db_t',
        content => $content,
        source  => $source,
        require => Package[$postgresql::params::server_packages],
        notify  => Service[$postgresql::params::server_services],
    }

}
