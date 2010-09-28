# /etc/puppet/modules/dart/manifests/classes/mdct-dev12.pp

class dart::mdct-dev12 inherits dart::workstation_node {
    $plymouth_default_theme = "details"
    include plymouth

    # passwords generated with bacula-password-generator package
    $bacula_client_director_password = "2hNcW1n2jkNU5ywm4TK6CrY2yDmqlEPcr2SoRP0abEHW"
    $bacula_client_director_monitor_password = "WqQvFNJdbiIfyxnKkoocVQFcNgY0CLVcKXok1TtrhJTH"
    include bacula::client

    include bacula::admin
    include mysql-server
    include packages::kde
    include repoview
    include yum-cron

    $SUFFIX=".orig-${operatingsystem}${operatingsystemrelease}"

    file { "/j":
        ensure	=> "/mnt-local/storage/j/",
        require => Service["autofs"],
    }

    file { "/Pound":
        ensure	=> "/mnt-local/storage/Pound/",
        require => Service["autofs"],
    }

    replace_original_with_symlink_to_alternate { "/etc/libvirt":
        alternate       => "/mnt-local/storage/j/etc/libvirt",
        backup          => "/etc/libvirt$SUFFIX",
        original        => "/etc/libvirt",
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require         => Package["libvirt"],
    }

    replace_original_with_symlink_to_alternate { "/var/lib/libvirt":
        alternate	=> "/mnt-local/storage/j/var/lib/libvirt",
        backup          => "/var/lib/libvirt$SUFFIX",
        original        => "/var/lib/libvirt",
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require         => Package["libvirt"],
    }

    replace_original_with_symlink_to_alternate { "/var/lib/mysql":
        alternate	=> "/mnt-local/storage/j/var/lib/mysql",
        backup          => "/var/lib/mysql$SUFFIX",
        original        => "/var/lib/mysql",
        before          => Service["mysqld"],
        require         => Package["mysql-server"],
    }

    mailalias { "root":
        ensure          => present,
        recipient       => "john.florian@dart.biz",
    }

}
