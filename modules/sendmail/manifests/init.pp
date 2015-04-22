# modules/sendmail/manifests/init.pp
#
# == Class: sendmail
#
# Manages a host with a basic mail configuration so that locally generated
# mail is forwarded to the local MX.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*enable*]
#   Instance is to be started at boot.  Either true or false (default).
#
# [*ensure*]
#   Instance is to be 'running' (default) or 'stopped'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class sendmail (
        $enable=false,
        $ensure='stopped',
    ) inherits ::sendmail::params {

    package { $::sendmail::params::packages:
        ensure => installed,
        notify => Service[$::sendmail::params::services],
    }

    service { $::sendmail::params::services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

    # Puppet will not automatically exec newaliases when mail aliases are
    # configured as it rightly makes no assumptions about the mail system
    # configuration.
    #
    # This is defined here, not in sendmail::alias from which the event
    # originates, because to define it there would result in duplicate
    # declarations of the Exec, iff more than one sendmail::alias is declared.
    exec { $::sendmail::params::newaliases_cmd:
        refreshonly => true,
        require     => Package[$::sendmail::params::packages],
    }

}
