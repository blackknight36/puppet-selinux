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
        recipient       => "john.florian@dart.biz",
    }

    file { "/root/.gvimrc_site":
        group	=> "root",
        mode    => "0644",
        owner   => "root",
        source  => "puppet:///private-host/gvimrc_site",
    }

}
