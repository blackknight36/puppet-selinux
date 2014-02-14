# modules/sendmail/alias.pp
#
# == Class: sendmail::alias
#
# Configures a mailing alias on the host.
#
# === Parameters
#
# [*namevar*]
#   The alias name.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*recipient*]
#   Where email should be sent.  Multiple values should be specified as an
#   array.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define sendmail::alias ($ensure='present', $recipient) {

    include 'sendmail::params'

    mailalias { $name:
        ensure      => $ensure,
        recipient   => $recipient,
        notify      => Exec[$sendmail::params::newaliases_cmd],
    }

    # Puppet will not automatically exec newaliases when mail aliases are
    # configured as it rightly makes no assumptions about the mail system
    # configuration.
    exec { $sendmail::params::newaliases_cmd:
        refreshonly => true,
        require     => Package[$sendmail::params::packages],
    }

}
