# modules/vsftpd/manifests/params.pp
#
# == Class: vsftpd::params
#
# Parameters for the vsftpd puppet module.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class vsftpd::params {

    case $::operatingsystem {
        Fedora: {

            $packages = [
                'vsftpd',
            ]
            $service_name = 'vsftpd'

            if $::operatingsystemrelease < 18 {
                $bool_allow_use_nfs = 'allow_ftpd_use_nfs'
            } else {
                $bool_allow_use_nfs = 'ftpd_use_nfs'
            }

        }

        default: {
            fail ("The vsftpd module is not yet supported on ${::operatingsystem}.")
        }

    }

}
