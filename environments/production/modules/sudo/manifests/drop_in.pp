# modules/sudo/manifests/drop_in.pp
#
# == Define: sudo::drop_in
#
# Installs a drop-in configuration file for sudo.
#
# === Parameters
#
# [*namevar*]
#   An arbitrary identifier for the drop-in instance unless the "filename"
#   parameter is not set in which case this must provide the value normally
#   set with the "filename" parameter.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*filename*]
#   Name to be given to the drop-in file within the sudoers.d directory.
#   Defaults to the value of the "namevar" parameter.
#
# [*content*]
#   Literal content for the drop-in file.  One and only one of "content"
#   or "source" must be given.
#
# [*source*]
#   URI of the drop-in file content.  One and only one of "content" or
#   "source" must be given.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define sudo::drop_in (
    $filename=$name,
    $ensure='present',
    $content=undef,
    $source=undef,
) {

    include 'sudo::params'

    file { "/etc/sudoers.d/${filename}":
        ensure      => $ensure,
        owner       => 'root',
        group       => 'root',
        mode        => '0440',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$sudo::params::packages],
        content     => $content,
        source      => $source,
    }

}
