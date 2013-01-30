# modules/dart/manifests/mdct-dev6.pp

class dart::mdct-dev6 inherits dart::abstract::workstation_node {

    class { 'network':
        network_manager => false,
        domain => 'dartcontainer.com',
        name_servers => ['10.1.0.98','10.1.0.99'],
    }

    network::interface { 'br0':
        template => 'static-bridge',
        ip_address  => '10.1.0.156',
        netmask     => '255.255.0.0',
        gateway     => '10.1.0.25',
    }

    network::interface { 'em1':
        template    => 'static',
        bridge      => 'br0',
    }

    class { 'xorg-server':
        config  => 'puppet:///private-host/etc/X11/xorg.conf',
        drivers => ['kmod-nvidia'],
    }

    class { 'plymouth':
        theme   => 'details',
    }

    include mysql-server
    include packages::kde
    include jetbrains::idea

    $SUFFIX=".orig-${operatingsystem}${operatingsystemrelease}"

    file { "/etc/.credentials":
        ensure	=> "/mnt-local/storage/etc/.credentials",
        require => Service["autofs"],
    }

    file { "/storage":
        ensure	=> "/mnt-local/storage/",
        require => Service["autofs"],
    }

    file { "/cpk":
        ensure	=> "/mnt-local/storage/pub/",
        require => Service["autofs"],
    }

    file { "/dist":
        ensure	=> "/mnt-local/storage/dist/",
        require => Service["autofs"],
    }

    file { "/etc/init.d/picaps":
        ensure	=> "/mnt-local/storage/dist/resource/init.d/picaps",
        require => Service["autofs"],
    }

    file { "/etc/sysconfig/picaps":
        ensure	=> "/mnt-local/storage/dist/resource/init.d/sysconfig",
        require => Service["autofs"],
    }

    file { "/usr/local/yjp":
        ensure	=> "/mnt-local/storage/usr/local/yjp",
        require => Service["autofs"],
    }

    replace_original_with_symlink_to_alternate { "/etc/libvirt":
        alternate       => "/mnt-local/storage/etc/libvirt",
        backup          => "/etc/libvirt$SUFFIX",
        original        => "/etc/libvirt",
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require         => Package["libvirt"],
        seltype         => "virt_etc_t",
    }

    replace_original_with_symlink_to_alternate { "/var/lib/libvirt":
        alternate	=> "/mnt-local/storage/var/lib/libvirt",
        backup          => "/var/lib/libvirt$SUFFIX",
        original        => "/var/lib/libvirt",
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require         => Package["libvirt"],
        seltype         => "virt_var_lib_t",
    }

    replace_original_with_symlink_to_alternate { "/var/lib/mysql":
        alternate	=> "/mnt-local/storage/var/lib/mysql",
        backup          => "/var/lib/mysql$SUFFIX",
        original        => "/var/lib/mysql",
        before          => Service["mysqld"],
        require         => Package["mysql-server"],
        seltype         => "mysqld_db_t",
    }

    mailalias { "root":
        ensure          => present,
        recipient       => "chris.kennedy@dart.biz",
    }
}
