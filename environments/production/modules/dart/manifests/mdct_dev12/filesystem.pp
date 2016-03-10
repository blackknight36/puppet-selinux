# modules/dart/manifests/mdct_dev12/filesystem.pp
#
# == Class: dart::mdct_dev12::filesystem
#
# Manage a bunch of filesystem details on John Florian's workstation.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_dev12::filesystem {

    Autofs::Map_entry {
        mount   => '/mnt',
    }

    autofs::map_entry {

        '/mnt/mas-fs02-d13677':
            key     => 'mas-fs02-d13677',
            options => '-fstype=cifs,uid=d13677,gid=d13677,credentials=/mnt/storage/j/.credentials/d13677.cifs',
            remote  => '://mas-fs02/Users/d13677';

        '/mnt/mas-fs01-eng':
            key     => 'mas-fs01-eng',
            options => '-fstype=cifs,credentials=/mnt/storage/j/.credentials/d13677.cifs',
            remote  => '://mas-fs01/Eng';

        '/mnt/mas-fs01-sharedata':
            key     => 'mas-fs01-sharedata',
            options => '-fstype=cifs,credentials=/mnt/storage/j/.credentials/d13677.cifs',
            remote  => '://mas-fs01/ShareData';

        '/mnt/storage':
            key     => 'storage',
            options => '-fstype=xfs,rw',
            remote  => ':/dev/disk/by-uuid/35f5e141-4534-4e7e-ac01-1c71b8a5e9a7';

    }

    Systemd::Mount {
        mnt_options     => 'bind',
        mnt_requires    => 'autofs.service',
        mnt_after       => 'autofs.service',
        require         => Class['autofs'],
    }

    systemd::mount {
        '/j':
            mnt_description => 'my local storage',
            mnt_what        => '/mnt/storage/j';

        '/Pound':
            mnt_description => 'tunez and pix',
            mnt_what        => '/mnt/storage/Pound';
    }

}
