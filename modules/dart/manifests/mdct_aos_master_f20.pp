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
        dir_passwd  => 'hobe9yveB940mWreqoVzfTMIXfWurWi5ROughoJw7A39',
        mon_passwd  => 'zdJxxdFhes9YxlJNhAHFOaSbneIy9N3FmlzTkA1wdowU',
    }

    class { 'dart::abstract::aos_master_node':
        django_user     => 'django',
        django_group    => 'django',
        python_ver      => '3.3',
    }

}
