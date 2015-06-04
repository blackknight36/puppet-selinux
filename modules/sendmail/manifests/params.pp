# modules/sendmail/params.pp
#
# == Class: sendmail::params
#
# Parameters for the sendmail puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class sendmail::params {

    case $::operatingsystem {
        Fedora: {

            $packages = 'sendmail'

            if $::operatingsystemrelease > 14 {
                $services = [
                    'sendmail',
                    'sm-client',
                ]
            } else {
                $services = 'sendmail'
            }

            $newaliases_cmd = '/usr/bin/newaliases'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
