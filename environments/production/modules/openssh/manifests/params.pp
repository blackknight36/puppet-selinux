# modules/openssh/manifests/params.pp
#
# == Class: openssh::params
#
# Parameters for the openssh puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#   John Florian <john.florian@dart.biz>


class openssh::params {

    case $::operatingsystem {
        'Fedora', 'CentOS': {

            $services = [
                'sshd',
            ]
            $packages = [
                'openssh-server',
            ]

        }

        default: {
            fail ("The openssh module is not yet supported on ${::operatingsystem}.")
        }

    }

}
