# modules/dart/manifests/mdct_aos_master_f20.pp
#
# == Class: dart::mdct_aos_master_f20
#
# Configures the AOS Master host.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_aos_master_f20 {

    class { 'bacula::client':
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => 'hobe9yveB940mWreqoVzfTMIXfWurWi5ROughoJw7A39',
        mon_name    => $dart::params::bacula_mon_name,
        mon_passwd  => 'zdJxxdFhes9YxlJNhAHFOaSbneIy9N3FmlzTkA1wdowU',
    }

    # Kludge for https://bugzilla.redhat.com/show_bug.cgi?id=1067236
    cron::job { 'restart-cron':
        command => 'systemctl restart crond.service',
        minute  => '53',
        hour    => '6',
    }

    class { 'dart::abstract::aos_master_node':
        django_user     => 'django',
        django_group    => 'django',
        python_ver      => '3.3',
    }

}
