# modules/sendmail/manifests/init.pp
#
# == Class: sendmail
#
# Configures a host with a basic mail configuration so that locally generated
# mail is forwarded to the local MX.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class sendmail {

    include 'sendmail::params'

    package { $sendmail::params::packages:
        ensure  => installed,
        notify  => Service[$sendmail::params::services],
    }

    service { $sendmail::params::services:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}
