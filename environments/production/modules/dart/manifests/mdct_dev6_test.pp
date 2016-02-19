# modules/dart/manifests/mdct_dev6_test.pp
#
# Synopsis:
#       Developer Workstation (experimental testing)
#
# Contact:
#       Chris Kennedy

class dart::mdct_dev6_test inherits dart::abstract::workstation_node {

    class { 'plymouth':
        theme   => 'details',
    }

    include 'mysql_server'

    service { 'NetworkManager':
        ensure     => stopped,
        enable     => false,
        hasrestart => true,
        hasstatus  => true,
    }

    service { 'network':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
    }

    $SUFFIX=".orig-${::operatingsystem}${::operatingsystemrelease}"

    autofs::map_entry { '/mnt/storage':
        mount   => '/mnt',
        key     => 'storage',
        options => '-fstype=ext3,rw',
        remote  => ':/dev/data/storage',
    }

    autofs::map_entry { '/mnt/mdct-dev12-aud':
        mount   => '/mnt',
        key     => 'mdct-dev12-aud',
        options => '-soft',
        remote  => 'mdct-dev12.dartcontainer.com:/Music',
    }

    autofs::map_entry { '/mnt/f15root':
        mount   => '/mnt',
        key     => 'f15root',
        options => '-fstype=ext4,ro',
        remote  => ':/dev/mdctdev6_2010/f15root/',
    }

    autofs::map_entry { '/mnt/mas9965':
        mount   => '/mnt',
        key     => 'mas9965',
        options => '-fstype=cifs,rw,credentials=/etc/.credentials/mas9965.cred',
        remote  => '://mas9965.dartcontainer.com/c\$',
    }

    autofs::map_entry { '/mnt/files-2k1-prodmondata':
        mount   => '/mnt',
        key     => 'files-2k1-prodmondata',
        options => '-fstype=cifs,rw,uid=d19749,gid=d19749,credentials=/etc/.credentials/d19749.cred',
        remote  => '://files-2k1/prodmondata',
    }

    autofs::map_entry { '/mnt/files-2k1-media':
        mount   => '/mnt',
        key     => 'files-2k1-media',
        options => '-fstype=cifs,rw,uid=d19749,gid=d19749,credentials=/etc/.credentials/d19749.cred',
        remote  => '://files-2k1/media',
    }

    autofs::map_entry { '/mnt/files-2k1-sharedata':
        mount   => '/mnt',
        key     => 'files-2k1-sharedata',
        options => '-fstype=cifs,rw,uid=d19749,gid=d19749,credentials=/etc/.credentials/d19749.cred',
        remote  => '://files-2k1/ShareData',
    }

    autofs::map_entry { '/mnt/files-2k1-eng':
        mount   => '/mnt',
        key     => 'files-2k1-eng',
        options => '-fstype=cifs,rw,uid=d19749,gid=d19749,credentials=/etc/.credentials/d19749.cred',
        remote  => '://files-2k1/Eng',
    }

    autofs::map_entry { '/mnt/d19749':
        mount   => '/mnt',
        key     => 'd19749',
        options => '-fstype=cifs,rw,uid=d19749,gid=d19749,credentials=/etc/.credentials/d19749.cred',
        remote  => '://mas-fs02/users/d19749',
    }

    file { '/etc/.credentials':
        ensure => link,
        target => '/mnt/storage/etc/.credentials',
    }

    file { '/storage':
        ensure => link,
        target => '/mnt/storage/',
    }

    file { '/cpk':
        ensure => link,
        taret  => '/mnt/storage/pub/',
    }

    file { '/dist':
        ensure => link,
        target => '/mnt/storage/dist/',
    }

    file { '/etc/init.d/picaps':
        ensure => link,
        target => '/mnt/storage/dist/resource/init.d/picaps',
    }

    file { '/etc/sysconfig/picaps':
        ensure => link,
        target => '/mnt/storage/dist/resource/init.d/sysconfig',
    }

    file { '/usr/local/idea':
        ensure => link,
        target => '/mnt/storage/usr/local/idea',
    }

    file { '/usr/local/yjp':
        ensure => link,
        target => '/mnt/storage/usr/local/yjp',
    }

    dart::util::replace_original_with_symlink_to_alternate { '/etc/libvirt':
        alternate => '/mnt/storage/etc/libvirt',
        backup    => "/etc/libvirt${SUFFIX}",
        original  => '/etc/libvirt',
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require   => Package['libvirt'],
    }

    dart::util::replace_original_with_symlink_to_alternate { '/var/lib/libvirt':
        alternate => '/mnt/storage/var/lib/libvirt',
        backup    => "/var/lib/libvirt${SUFFIX}",
        original  => '/var/lib/libvirt',
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require   => Package['libvirt'],
    }

    dart::util::replace_original_with_symlink_to_alternate { '/var/lib/mysql':
        alternate => '/mnt/storage/var/lib/mysql',
        backup    => "/var/lib/mysql${SUFFIX}",
        original  => '/var/lib/mysql',
        before    => Service['mysqld'],
        require   => Package['mysql-server'],
    }

    sendmail::alias { 'root':
        recipient   => 'chris.kennedy@dart.biz',
    }

}
