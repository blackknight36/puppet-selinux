# modules/dart/manifests/classes/mdct-dev6-test.pp

class dart::mdct-dev6-test inherits dart::abstract::workstation_node {
    $plymouth_default_theme = "details"
    include plymouth
    include mysql-server
    include packages::kde

    service { "NetworkManager":
        enable          => false,
        ensure          => stopped,
        hasrestart      => true,
        hasstatus       => true,
    }

    service { "network":
        enable          => true,
        ensure          => running,
        hasrestart      => true,
        hasstatus       => true,
    }

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

    file { "/usr/local/idea":
        ensure	=> "/mnt-local/storage/usr/local/idea",
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
    }

    replace_original_with_symlink_to_alternate { "/var/lib/libvirt":
        alternate	=> "/mnt-local/storage/var/lib/libvirt",
        backup          => "/var/lib/libvirt$SUFFIX",
        original        => "/var/lib/libvirt",
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require         => Package["libvirt"],
    }

    replace_original_with_symlink_to_alternate { "/var/lib/mysql":
        alternate	=> "/mnt-local/storage/var/lib/mysql",
        backup          => "/var/lib/mysql$SUFFIX",
        original        => "/var/lib/mysql",
        before          => Service["mysqld"],
        require         => Package["mysql-server"],
    }

    mailalias { "root":
        ensure          => present,
        recipient       => "chris.kennedy@dart.biz",
    }
}
