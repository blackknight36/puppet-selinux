# modules/puppet/manifests/tools.pp
#
# == Class: puppet::tools
#
# Configures the puppet-tools package on a host.
#
# === Parameters
#
# [*cron_cleanup*]
#   Source URI for cron job file that schedules puppet-report-cleanup.
#
# [*tools_conf*]
#   Source URI for the configuration file for the puppet-tools package.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class puppet::tools ($cron_cleanup, $tools_conf=undef) {

    include 'cron::daemon'
    include 'puppet::params'

    package { $puppet::params::tools_packages:
        ensure  => installed,
    }

    file { '/etc/puppet-tools.conf':
        owner       => 'root',
        group       => 'puppet',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'puppet_etc_t',
        source      => $tools_conf ? {
            undef   => 'puppet:///modules/puppet/puppet-tools.conf',
            default => $tools_conf,
        },
        before      => Cron::Jobfile['puppet-report-cleanup'],
        subscribe   => Package[$puppet::params::tools_packages],
    }

    cron::jobfile { 'puppet-report-cleanup':
        source  => $cron_cleanup,
    }

}
