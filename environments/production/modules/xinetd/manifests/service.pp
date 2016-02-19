# modules/xinetd/manifests/service.pp
#
# == Define: xinetd::service
#
# Installs a service configuration file for xinetd.
#
# === Parameters
#
# [*namevar*]
#   An arbitrary identifier for the service instance.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*content*]
#   Literal content for the service file.  One and only one of "content"
#   or "source" must be given.
#
# [*source*]
#   URI of the service file content.  One and only one of "content" or
#   "source" must be given.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define xinetd::service ($ensure='present', $content=undef, $source=undef) {

    include 'xinetd::params'

    file { "/etc/xinetd.d/${name}":
        ensure      => $ensure,
        owner       => 'root',
        group       => 'root',
        mode        => '0600',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$xinetd::params::service_name],
        notify      => Service[$xinetd::params::service_name],
        subscribe   => Package[$xinetd::params::packages],
        content     => $content,
        source      => $source,
    }

}
