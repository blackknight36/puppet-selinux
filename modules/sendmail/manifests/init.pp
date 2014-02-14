# modules/sendmail/manifests/init.pp
#
# == Class: sendmail
#
# Configures a host with a basic mail configuration so that locally generated
# mail is forwarded to the local MX.
#
# === Parameters
#
# [*enable*]
#   Should the service be enabled and running?  Must be one of true or false
#   (default).
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class sendmail ($enable=false) {

    include 'sendmail::params'

    package { $sendmail::params::packages:
        ensure  => installed,
        notify  => Service[$sendmail::params::services],
    }

    service { $sendmail::params::services:
        enable      => $enable,
        ensure      => $enable ? {
            true    => running,
            default => stopped,
        },
        hasrestart  => true,
        hasstatus   => true,
    }

}
