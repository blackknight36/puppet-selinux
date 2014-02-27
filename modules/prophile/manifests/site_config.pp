# modules/prophile/manifests/site_config.pp
#
# == Define: prophile::site_config
#
# Installs a site-specific resource file for prophile.
#
# === Parameters
#
# [*namevar*]
#   Path name of deployed resource file.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*content*]
#   Literal content for the site_config file.  One and only one of "content"
#   or "source" must be given.
#
# [*source*]
#   URI of the site_config file content.  One and only one of "content" or
#   "source" must be given.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


define prophile::site_config (
        $ensure='present', $content=undef, $source=undef,
    ) {

    file { "${name}":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0640',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'admin_home_t',
        content => $content,
        source  => $source,
    }

}
