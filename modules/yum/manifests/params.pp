# modules/yum/manifests/params.pp
#
# Synopsis:
#       Parameters for the yum puppet module.


class yum::params {

    case $::operatingsystem {
        Fedora: {

            $services = [
                'yum-cron',
            ]
            $packages = [
                'yum-cron',
            ]

            if $::operatingsystemrelease < 19 {
                $cron_conf_target = '/etc/sysconfig/yum-cron'
            } else {
                # Fedora 19 also provides an hourly job, but it will be left
                # at its default (i.e., disabled).
                $cron_conf_target = '/etc/yum/yum-cron.conf'
            }

        }

        default: {
            fail ("The yum module is not yet supported on ${operatingsystem}.")
        }

    }

}
