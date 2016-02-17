# modules/dart/manifests/subsys/yum_cron.pp

class dart::subsys::yum_cron {

    if $::operatingsystemrelease < '19' {
        $yum_cron_conf = 'yum-cron.conf.Fedora18-'
    } else {
        # Fedora 19 also provides an hourly job, but it will be left
        # at its default (i.e., disabled).
        $yum_cron_conf = 'yum-cron.conf.Fedora19+'
    }
    class { 'yum::cron':
        conf_source => "puppet:///private-domain/yum/${yum_cron_conf}",
    }

}
