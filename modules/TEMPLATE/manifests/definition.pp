# modules/MODULE_NAME/manifests/DEFINE_NAME.pp
#
# == Define: MODULE_NAME::DEFINE_NAME
#
# Installs a DEFINE_NAME configuration file for MODULE_NAME.
#
# === Parameters
#
# [*namevar*]
#   An arbitrary identifier for the DEFINE_NAME instance unless the "foo"
#   parameter is not set in which case this must provide the value normally
#   set with the "foo" parameter.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*content*]
#   Literal content for the DEFINE_NAME file.  If neither "content" nor
#   "source" is given, the content of the file will be left unmanaged.
#
# [*source*]
#   URI of the DEFINE_NAME file content.  If neither "content" nor "source" is
#   given, the content of the file will be left unmanaged.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>


define MODULE_NAME::DEFINE_NAME (
        $ensure='present',
        $content=undef,
        $source=undef,
    ) {

    include 'MODULE_NAME::params'

    file { "/CONFIG_PATH/${name}.conf":
        ensure    => $ensure,
        owner     => 'root',
        group     => 'root',
        mode      => '0640',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'MODULE_NAME_config_t',
        before    => Service[$MODULE_NAME::params::service_name],
        notify    => Service[$MODULE_NAME::params::service_name],
        subscribe => Package[$MODULE_NAME::params::packages],
        content   => $content,
        source    => $source,
    }

}
