# modules/sigul/manifests/init.pp
#
# == Class: sigul
#
# Manages resources common to all usages of Sigul be it Client, Bridge or
# Server.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class sigul inherits ::sigul::params {

    package { $::sigul::params::packages:
        ensure => installed,
    }

    # Sigul Server/Bridge log files go mute after log rotation
    #
    # Neither the Server nor Bridge reopen their log files after logrotate
    # truncates.  This config change addresses logrotate to use copytruncate
    # option.  Sigul code could be adjusted as a better alternative.
    #
    # Regardless, in the meantime this resolves:
    #       https://bugzilla.redhat.com/show_bug.cgi?id=1222957
    file { '/etc/logrotate.d/sigul':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        source  => 'puppet:///modules/sigul/sigul.logrotate',
    }

}