# modules/dart/manifests/mdct_aos_master_f19.pp
#
# == Class: dart::mdct_aos_master_f19
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


class dart::mdct_aos_master_f19 inherits dart::abstract::aos_master_node {

    class { 'bacula::client':
        dir_passwd  => 'hobe9yveB940mWreqoVzfTMIXfWurWi5ROughoJw7A39',
        mon_passwd  => 'zdJxxdFhes9YxlJNhAHFOaSbneIy9N3FmlzTkA1wdowU',
    }

}
