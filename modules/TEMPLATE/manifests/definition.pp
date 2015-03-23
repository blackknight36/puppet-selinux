# modules/MODULE_NAME/manifests/DEFINE_NAME.pp
#
# == Define: MODULE_NAME::DEFINE_NAME
#
# Manages a DEFINE_NAME configuration file for MODULE_NAME.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   An arbitrary identifier for the DEFINE_NAME instance unless the "FOO"
#   parameter is not set in which case this must provide the value normally
#   set with the "FOO" parameter.
#
# ==== Optional
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*FOO*]
#   This may be used in place of "namevar" if it's beneficial to give namevar
#   an arbitrary value.
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
        $FOO=undef,
        $content=undef,
        $source=undef,
    ) {

    include '::MODULE_NAME::params'

    if $FOO {
        $FOO_ = $FOO
    } else {
        $FOO_ = $name
    }

    file { "/CONFIG_PATH/${FOO_}.conf":
        ensure    => $ensure,
        owner     => 'root',
        group     => 'root',
        mode      => '0640',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'MODULE_NAME_config_t',
        before    => Service[$::MODULE_NAME::params::services],
        notify    => Service[$::MODULE_NAME::params::services],
        subscribe => Package[$::MODULE_NAME::params::packages],
        content   => $content,
        source    => $source,
    }

    $cmd = 'some_command --common --options'

    case $ensure {

        'present', true: {
            exec { "create MODULE_NAME DEFINE_NAME ${FOO_}":
                command   => "${cmd} create ${FOO_}",
                unless    => "${cmd} show ${FOO_}",
                before    => Service[$::MODULE_NAME::params::services],
                notify    => Service[$::MODULE_NAME::params::services],
                subscribe => Package[$::MODULE_NAME::params::packages],
            }
        }

        'absent', false: {
            exec { "delete MODULE_NAME DEFINE_NAME ${FOO_}":
                command   => "${cmd} delete ${FOO_}",
                onlyif    => "${cmd} show ${FOO_}",
                # before, notify and subscribe need special attention here.
                # There's likely no good template model; each case is unique.
                before    => Service[$::MODULE_NAME::params::services],
                notify    => Service[$::MODULE_NAME::params::services],
                subscribe => Package[$::MODULE_NAME::params::packages],
            }
        }

        default: {
            fail ("${title}: ensure value '${ensure})' is not supported")
        }

    }

}
