# modules/mirrmaid/manifests/config.pp
#
# == Define: mirrmaid::config
#
# Installs a configuration file for mirrmaid.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   Instance name for the config file, resulting in:
#   /etc/mirrmaid/${name}.conf
#
# ==== Optional
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*content*]
#   Literal content for the configuration file.  If neither "content" nor
#   "source" is given, the content of the file will be left unmanaged.
#
# [*source*]
#   URI of the configuration file content.  If neither "content" nor "source"
#   is given, the content of the file will be left unmanaged.
#
# [*cron_source*]
#   URI of the cron job file to be installed.  Use the default (undef) if you
#   do not want a cron job file installed.  See the cron::jobfile definition
#   for more details regarding format, requirements, etc.
#
# [*cron_content*]
#   Literal content for the  cron job file to be installed.  Use the default
#   (undef) if you do not want a cron job file installed.  See the
#   cron::jobfile definition for more details regarding format, requirements,
#   etc.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>
#   John Florian <jflorian@doubledog.org>


define mirrmaid::config (
        $ensure='present',
        $content=undef,
        $source=undef,
        $cron_content=undef,
        $cron_source=undef,
    ) {

    include '::cron::daemon'
    include '::mirrmaid::params'

    file { "/etc/mirrmaid/${name}.conf":
        ensure    => $ensure,
        owner     => 'root',
        group     => 'mirrmaid',
        mode      => '0640',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::mirrmaid::params::packages],
        content   => $content,
        source    => $source,
    }

    if $cron_content != undef or $cron_source != undef {

        cron::jobfile { $name:
            require => Class['::mirrmaid'],
            content => $cron_content,
            source  => $cron_source,
        }

    }

}
