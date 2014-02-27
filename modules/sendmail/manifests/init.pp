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

    # Puppet will not automatically exec newaliases when mail aliases are
    # configured as it rightly makes no assumptions about the mail system
    # configuration.
    #
    # This is defined here, not in sendmail::alias from which the event
    # originates, because to define it there would result in duplicate
    # declarations of the Exec, iff more than one sendmail::alias is declared.
    exec { $sendmail::params::newaliases_cmd:
        refreshonly => true,
        require     => Package[$sendmail::params::packages],
    }

}
