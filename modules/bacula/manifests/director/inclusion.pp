# modules/bacula/manifests/director/inclusion.pp
#
# == Define: bacula::director::inclusion
#
# Installs a configuration file fragment for inclusion in the Bacula
# Director's main configuration file.
#
# === Parameters
#
# [*namevar*]
#   The name of the configuration file fragment.  Path details should be
#   omitted as should the '.conf' suffix which will be forced.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*content*]
#   Literal content for the inclusion file.  One and only one of "content"
#   or "source" must be given.
#
# [*source*]
#   URI of the inclusion file content.  One and only one of "content" or
#   "source" must be given.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define bacula::director::inclusion (
    $ensure='present', $content=undef, $source=undef
    ) {

    include 'bacula::params'

    file { "/etc/bacula/director/${name}.conf":
        ensure      => $ensure,
        owner       => 'root',
        group       => 'bacula',
        mode        => '0640',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$bacula::params::dir_service_name],
        notify      => Service[$bacula::params::dir_service_name],
        subscribe   => Package[$bacula::params::dir_packages],
        content     => $content,
        source      => $source,
    }

}
