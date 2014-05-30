# modules/dart/manifests/mdct_dev6.pp
#
# Synopsis:
#       Developer Workstation
#
# Contact:
#       Chris Kennedy

class dart::mdct_dev6 inherits dart::abstract::workstation_node {

    class { 'network':
        service         => 'legacy',
        domain          => $dart::params::dns_domain,
        name_servers    => $dart::params::dns_servers,
    }

    network::interface { 'br0':
        template    => 'static-bridge',
        ip_address  => '10.1.0.156',
        netmask     => '255.255.0.0',
        gateway     => '10.1.0.25',
        stp         => 'no',
    }

    network::interface { 'em1':
        template    => 'static',
        bridge      => 'br0',
    }

#   class { 'xorg_server':
#       config  => 'puppet:///private-host/etc/X11/xorg.conf',
#       drivers => ['kmod-nvidia'],
#   }

    class { 'plymouth':
        theme   => 'details',
    }

#    include 'mysql_server'
    include 'jetbrains::idea'

    $SUFFIX=".orig-${operatingsystem}${operatingsystemrelease}"

    autofs::map_entry { '/mnt/storage':
        mount   => '/mnt',
        key     => 'storage',
        options => '-fstype=ext4,rw',
        remote  => ':/dev/data2013/storage',
    }

    autofs::map_entry { '/mnt/storage-old':
        mount   => '/mnt',
        key     => 'storage-old',
        options => '-fstype=ext3,rw',
        remote  => ':/dev/data/storage',
    }

    autofs::map_entry { '/mnt/mdct-dev12-aud':
        mount   => '/mnt',
        key     => 'mdct-dev12-aud',
        options => '-soft',
        remote  => 'mdct-dev12.dartcontainer.com:/Music',
    }

    autofs::map_entry { '/mnt/mas9965':
        mount   => '/mnt',
        key     => 'mas9965',
        options => '-fstype=cifs,rw,credentials=/etc/.credentials/mas9965.cred',
        remote  => '://mas9965.dartcontainer.com/c\$',
    }

    autofs::map_entry { '/mnt/mas-fs01-prodmondata':
        mount   => '/mnt',
        key     => 'mas-fs01-prodmondata',
        options => '-fstype=cifs,rw,uid=d19749,gid=d19749,credentials=/etc/.credentials/d19749.cred',
        remote  => '://mas-fs01/prodmondata',
    }

    autofs::map_entry { '/mnt/mas-fs01-media':
        mount   => '/mnt',
        key     => 'mas-fs01-media',
        options => '-fstype=cifs,rw,uid=d19749,gid=d19749,credentials=/etc/.credentials/d19749.cred',
        remote  => '://mas-fs01/media',
    }

    autofs::map_entry { '/mnt/mas-fs01-sharedata':
        mount   => '/mnt',
        key     => 'mas-fs01-sharedata',
        options => '-fstype=cifs,rw,uid=d19749,gid=d19749,credentials=/etc/.credentials/d19749.cred',
        remote  => '://mas-fs01/ShareData',
    }

    autofs::map_entry { '/mnt/mas-fs01-eng':
        mount   => '/mnt',
        key     => 'mas-fs01-eng',
        options => '-fstype=cifs,rw,uid=d19749,gid=d19749,credentials=/etc/.credentials/d19749.cred',
        remote  => '://mas-fs01/Eng',
    }

    autofs::map_entry { '/mnt/d19749':
        mount   => '/mnt',
        key     => 'd19749',
        options => '-fstype=cifs,rw,uid=d19749,gid=d19749,credentials=/etc/.credentials/d19749.cred',
        remote  => '://mas-fs02/users/d19749',
    }

    file { "/etc/.credentials":
        ensure  => link,
        target  => "/mnt/storage/etc/.credentials",
    }

    file { "/storage":
        ensure  => link,
        target  => "/mnt/storage/",
    }

    file { "/cpk":
        ensure  => link,
        taret   => "/mnt/storage/pub/",
    }

    file { "/dist":
        ensure  => link,
        target  => "/mnt/storage/dist/",
    }

    file { "/etc/init.d/picaps":
        ensure  => link,
        target  => "/mnt/storage/dist/resource/init.d/picaps",
    }

    file { "/etc/sysconfig/picaps":
        ensure  => link,
        target  => "/mnt/storage/dist/resource/init.d/sysconfig",
    }

    file { "/usr/local/yjp":
        ensure  => link,
        target  => "/mnt/storage/usr/local/yjp",
    }

    file { "/usr/local/selinux":
        ensure  => link,
        target  => "/mnt/storage/usr/local/selinux",
    }

    dart::util::replace_original_with_symlink_to_alternate { "/etc/libvirt":
        alternate   => "/mnt/storage/etc/libvirt",
        backup      => "/etc/libvirt$SUFFIX",
        original    => "/etc/libvirt",
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require     => Package["libvirt"],
        seltype     => "virt_etc_t",
    }

    dart::util::replace_original_with_symlink_to_alternate { "/var/lib/libvirt":
        alternate   => "/mnt/storage/var/lib/libvirt",
        backup      => "/var/lib/libvirt$SUFFIX",
        original    => "/var/lib/libvirt",
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require     => Package["libvirt"],
        seltype     => "virt_var_lib_t",
    }

#    dart::util::replace_original_with_symlink_to_alternate { "/var/lib/mysql":
#        alternate   => "/mnt/storage/var/lib/mysql",
#        backup      => "/var/lib/mysql$SUFFIX",
#        original    => "/var/lib/mysql",
#        before      => Service["mysqld"],
#        require     => Package["mysql-server"],
#        seltype     => "mysqld_db_t",
#    }

    sendmail::alias { 'root':
        recipient   => 'chris.kennedy@dart.biz',
    }
}
