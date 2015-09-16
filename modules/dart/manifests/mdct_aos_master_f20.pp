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

    class { 'jaf_bacula::client':
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => 'hobe9yveB940mWreqoVzfTMIXfWurWi5ROughoJw7A39',
        mon_name    => $dart::params::bacula_mon_name,
        mon_passwd  => 'zdJxxdFhes9YxlJNhAHFOaSbneIy9N3FmlzTkA1wdowU',
    }

    class { 'dart::abstract::aos_master_node':
        django_user     => 'django',
        django_group    => 'django',
        python_ver      => '3.3',
    }

}
