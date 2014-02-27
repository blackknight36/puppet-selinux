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

}
