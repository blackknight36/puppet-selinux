# modules/dart/manifests/classes/mdct-aos-master-f15.pp

class dart::mdct-aos-master-f15 inherits dart::aos_master_node {

    $bacula_client_director_password = "hobe9yveB940mWreqoVzfTMIXfWurWi5ROughoJw7A39"
    $bacula_client_director_monitor_password = "zdJxxdFhes9YxlJNhAHFOaSbneIy9N3FmlzTkA1wdowU"
    include 'bacula::client'

    include 'apache'

    apache::bind-mount { 'pub':
        source  => '/pub/',
    }

    apache::site-config { 'pub':
        notify  => Service['httpd'],
        source  => 'puppet:///private-host/apache/pub.conf',
    }

}
