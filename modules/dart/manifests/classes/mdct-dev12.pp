# /etc/puppet/modules/dart/manifests/classes/mdct-dev12.pp

class dart::mdct-dev12 inherits dart::workstation_node {
    $plymouth_default_theme = "details"
    include plymouth

    $bacula_client_director_password = "204f4392ecdcfd3324ce6efb2cb142f4"
    $bacula_client_director_monitor_password = "9183e6fe26d853f50e9e57e561057951"
    include bacula::client

    include bacula::admin
    include mysql-server
    include packages::kde
    include repoview
    include yum-cron

    # noscript included here because nobody else likely to want it
    package { "mozilla-noscript":
        ensure  => installed,
    }

    $SUFFIX=".orig-${operatingsystem}${operatingsystemrelease}"

    file { "/j":
        ensure	=> "/mnt-local/storage/j/",
        require => Service["autofs"],
    }

    file { "/s":
        ensure	=> "/mnt-local/storage/",
        require => Service["autofs"],
    }

    file { "/Pound":
        ensure	=> "/mnt-local/storage/Pound/",
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
    }

    replace_original_with_symlink_to_alternate { "/var/lib/mysql":
        alternate	=> "/mnt-local/storage/var/lib/mysql",
        backup          => "/var/lib/mysql$SUFFIX",
        original        => "/var/lib/mysql",
        before          => Service["mysqld"],
        require         => Package["mysql-server"],
    }

    file { "/exports":
        ensure  => directory,
        group	=> "root",
        mode    => "0755",
        owner   => "root",
    }

    file { "/exports/Music":
        ensure  => directory,
        group	=> "root",
        mode    => "0755",
        owner   => "root",
        require => File["/exports"],
    }

    mount { "/exports/Music":
        # NB atboot and noauto seem conflicting but do work.  Essentially,
        # puppet will make the mount, which will occur after autofs has
        # started (as needed).
        atboot  => true,
        device  => "/Pound/Library/Audio/Music/",
        ensure  => "mounted",
        fstype  => "none",
        options => "bind,noauto,context=system_u:object_r:usr_t",
        require => File["/exports/Music"],
    }

    exec { "open-nfs4-port":
        command => "lokkit --port=2049:tcp",
        unless  => "grep -q -- '-A INPUT .* -p tcp --dport 2049 -j ACCEPT' /etc/sysconfig/iptables",
    }

    service { "nfslock":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
    }

    service { "nfs":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
            Exec["open-nfs4-port"],
            Mount["/exports/Music"],
            Service["nfslock"],
        ],
    }

    mount { "/opt":
        # NB atboot and noauto seem conflicting but do work.  Essentially,
        # puppet will make the mount, which will occur after autofs has
        # started (as needed).
        atboot  => true,
        device  => "/mnt-local/storage/opt",
        ensure  => "mounted",
        fstype  => "none",
        options => "bind,noauto,context=system_u:object_r:usr_t",
    }

    mailalias { "root":
        ensure          => present,
        recipient       => "john.florian@dart.biz",
    }

    file { "/root/.gvimrc_site":
        group	=> "root",
        mode    => "0644",
        owner   => "root",
        source  => "puppet:///private-host/gvimrc_site",
    }

    file { "/root/.gitconfig":
        group	=> "root",
        mode    => "0644",
        owner   => "root",
        source  => "puppet:///private-host/git/gitconfig",
    }

    file { "/root/.gitignore":
        group	=> "root",
        mode    => "0644",
        owner   => "root",
        source  => "puppet:///private-host/git/gitignore",
    }

}
