# modules/bacula/manifests/params.pp
#
# == Class: jaf_bacula::params
#
# Parameters for the bacula puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class jaf_bacula::params {

    case $::operatingsystem {
        'Fedora': {

            # Administrator Tools
            $admin_packages = [
                'bacula-console-bat',
                'bacula-traymonitor',
            ]

            # Bacula Common
            $common_packages = [
                'bacula-common',
                'bacula-libs',
            ]
            if $::operatingsystemrelease < '19' {
                $dir_sd_common_packages = [
                    'bacula-libs-postgresql',
                ]
            } else {
                $dir_sd_common_packages = [
                ]
            }

            # Bacula Console
            $con_packages = [
                'bacula-console',
            ]

            # Bacula Client
            $fd_packages = [
                'bacula-client',
            ]
            $fd_service_name = 'bacula-fd'

            if $::operatingsystemrelease < '19' {
                # Bacula Director
                $dir_packages = [
                    'bacula-director-common',
                    'bacula-director-postgresql',
                ]
                $dir_service_name = 'bacula-dir'

                # Bacula Storage Daemon
                $sd_packages = [
                    'bacula-storage-common',
                    'bacula-storage-postgresql',
                ]
                $sd_service_name = 'bacula-sd'
            } else {
                # Bacula Director
                $dir_packages = [
                    'bacula-director',
                ]
                $dir_service_name = 'bacula-dir'

                # Bacula Storage Daemon
                $sd_packages = [
                    'bacula-storage',
                ]
                $sd_service_name = 'bacula-sd'
            }

        }

        default: {
            fail ("The bacula module is not yet supported on ${operatingsystem}.")
        }

    }

}
