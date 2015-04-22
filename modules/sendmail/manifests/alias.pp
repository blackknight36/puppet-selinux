# modules/sendmail/alias.pp
#
# == Class: sendmail::alias
#
# Configures a mailing alias on the host.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   The alias name.
#
# [*recipient*]
#   Where email should be sent.  Multiple values must be specified as an
#   array.
#
# ==== Optional
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


define sendmail::alias (
        $recipient,
        $ensure='present',
    ) {

    include '::sendmail'
    include '::sendmail::params'

    mailalias { $name:
        ensure    => $ensure,
        recipient => $recipient,
        notify    => Exec[$::sendmail::params::newaliases_cmd],
    }

}
