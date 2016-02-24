# modules/logwatch/manifests/init.pp
#
# == Class: logwatch
#
# Manages logwatch on a host.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*conf_source*]
#   URI of the main configuration (logwatch.conf) file content.  The default
#   is to use one provided by this module.
#
# [*ignore_source*]
#   URI of the ignore.conf file content.  The default is to use one provided
#   by this module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>

class logwatch (
        $conf_source='puppet:///modules/logwatch/logwatch.conf',
        $ignore_source='puppet:///modules/logwatch/ignore.conf',
    ) inherits ::logwatch::params {

    package { $::logwatch::params::packages:
        ensure => installed,
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0640',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        subscribe => Package[$::logwatch::params::packages],
    }

    file {
        '/etc/logwatch/conf/ignore.conf':
            source => $ignore_source,
        ;

        '/etc/logwatch/conf/logwatch.conf':
            source => $conf_source,
        ;
    }

    # There is no logwatch "service" to manage; it's just a cron job.

}
