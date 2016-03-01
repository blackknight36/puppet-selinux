# modules/puppet/manifests/tools.pp
#
# == Class: puppet::tools
#
# Manages the puppet tools on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*conf_content*]
#   Literal content for the puppet-tools configuration file.  If neither
#   "conf_content" nor "conf_source" is given, the content of the file will be
#   left unmanaged.
#
# [*conf_source*]
#   URI of the puppet-tools configuration file content.  If neither
#   "conf_content" nor "conf_source" is given, the content of the file will be
#   left unmanaged.
#
# [*cron_content*]
#   Literal content for the puppet-tools cron job file.  If neither
#   "cron_content" nor "cron_source" is given, the content of the file will be
#   left unmanaged.
#
# [*cron_source*]
#   URI of the puppet-tools cron job file content.  If neither "cron_content"
#   nor "cron_source" is given, the content of the file will be left
#   unmanaged.
#
# [*lint_content*]
#   Literal content for the puppet-lint configuration file.  If neither
#   "lint_content" nor "lint_source" is given, the content of the file will be
#   left unmanaged.
#
# [*lint_source*]
#   URI of the puppet-lint configuration file content.  If neither
#   "lint_content" nor "lint_source" is given, the content of the file will be
#   left unmanaged.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2012-2016 John Florian


class puppet::tools (
        $conf_content=undef,
        $conf_source=undef,
        $cron_content=undef,
        $cron_source=undef,
        $lint_content=undef,
        $lint_source=undef,
    ) inherits ::puppet::params {

    package { $::puppet::params::tools_packages:
        ensure  => installed,
    }

    File {
        owner     => 'root',
        group     => 'puppet',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::puppet::params::tools_packages],
    }

    file { '/etc/puppet-tools.conf':
        seltype => 'puppet_etc_t',
        before  => Cron::Jobfile['puppet-tools'],
        content => $conf_content,
        source  => $conf_source,
    }

    file { '/etc/puppet-lint.rc':
        content => $lint_content,
        source  => $lint_source,
    }

    cron::jobfile { 'puppet-tools':
        content => $cron_content,
        source  => $cron_source,
    }

}
