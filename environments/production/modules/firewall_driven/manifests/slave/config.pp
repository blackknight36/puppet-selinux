# modules/firewall_driven/manifests/slave/config.pp
#
# == Define: firewall_driven::slave::config
#
# Installs a configuration file for firewall-driven-slave.
#
# === Parameters
#
# [*namevar*]
#   Name of the configuration file sans the path and the implied ".conf"
#   suffix.  See also the "path" parameter.
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
# [*path*]
#   Path to configuration file sans the base name.  Defaults to '/etc'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define firewall_driven::slave::config (
        $ensure='present',
        $content=undef,
        $source=undef,
        $path='/etc',
    ) {

    include 'firewall_driven::slave::params'

    file { "${path}/${name}.conf":
        ensure      => $ensure,
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$firewall_driven::slave::params::service],
        notify      => Service[$firewall_driven::slave::params::service],
        subscribe   => Package[$firewall_driven::slave::params::packages],
        content     => $content,
        source      => $source,
    }

}
