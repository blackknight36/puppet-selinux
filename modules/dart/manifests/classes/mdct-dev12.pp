# modules/dart/manifests/classes/mdct-dev12.pp

class dart::mdct-dev12 inherits dart::workstation_node {
    $plymouth_default_theme = "details"
    include plymouth

    $bacula_client_director_password = "204f4392ecdcfd3324ce6efb2cb142f4"
    $bacula_client_director_monitor_password = "9183e6fe26d853f50e9e57e561057951"
    include bacula::client

    include bacula::admin
    include mysql-server
    include packages::kde
    include yum-cron

    class { 'iptables':
        enabled => true,
    }

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
        before          => Service["libvirtd"],
        notify          => Service["libvirtd"],
        original        => "/etc/libvirt",
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require         => Package["libvirt"],
        seltype         => "virt_etc_t",
    }

    replace_original_with_symlink_to_alternate { "/var/lib/libvirt":
        alternate	=> "/mnt-local/storage/var/lib/libvirt",
        backup          => "/var/lib/libvirt$SUFFIX",
        before          => Service["libvirtd"],
        notify          => Service["libvirtd"],
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

    service { "libvirtd":
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
        ],
    }

    mount { "/opt":
        atboot  => true,
        device  => "/mnt-local/storage/opt",
        ensure  => "mounted",
        fstype  => "none",
        options => "_netdev,rbind,context=system_u:object_r:usr_t",
    }

    mailalias { "root":
        ensure          => present,
        recipient       => "john.florian@dart.biz",
    }

    # Make root user source my prophile by default.
    exec { "prophile-install -f jflorian":
        require => Package["prophile"],
        unless  => "grep -q prophile /root/.bash_profile",
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
