# modules/dart/manifests/mdct-aos-master-f19.pp

class dart::mdct-aos-master-f19 inherits dart::abstract::aos_master_node {

    class { 'bacula::client':
        dir_passwd  => 'hobe9yveB940mWreqoVzfTMIXfWurWi5ROughoJw7A39',
        mon_passwd  => 'zdJxxdFhes9YxlJNhAHFOaSbneIy9N3FmlzTkA1wdowU',
    }

}
