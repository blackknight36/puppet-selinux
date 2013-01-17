# modules/dart/manifests/mdct-dev12.pp

class dart::mdct-dev12 inherits dart::abstract::workstation_node {

    class { 'xorg-server':
        config  => 'puppet:///private-host/etc/X11/xorg.conf',
        drivers => ['kmod-nvidia'],
    }

    class { 'plymouth':
        theme   => 'details',
    }

    class { 'bacula::client':
        dir_passwd      => '204f4392ecdcfd3324ce6efb2cb142f4',
        mon_passwd      => '9183e6fe26d853f50e9e57e561057951',
    }

    include 'bacula::admin'
    include 'jetbrains::idea'
    include 'jetbrains::pycharm'
    include 'packages::kde'
    include 'yum-cron'

    class { 'iptables':
        enabled => true,
    }

    lokkit::rules_file { 'blocks':
        source  => 'puppet:///private-host/lokkit/blocks',
    }

    # noscript included here because nobody else likely to want it
    package { 'mozilla-noscript':
        ensure  => installed,
    }

    # JDK concept developing here until sufficient for everyone.  Must
    # consider PICAPS developers who may not want the latest or standard
    # release, whatever that may be.  I want it only for PyCharm, at this
    # time.
    package { 'jdk':
        ensure      => installed,
        provider    => 'rpm',
        source      => '/pub/oracle/jdk-7u10-linux-x64.rpm',
    }

    $SUFFIX=".orig-${operatingsystem}${operatingsystemrelease}"

    file { '/j':
        ensure	=> '/mnt-local/storage/j/',
        require => Service['autofs'],
    }

    file { '/s':
        ensure	=> '/mnt-local/storage/',
        require => Service['autofs'],
    }

    file { '/Pound':
        ensure	=> '/mnt-local/storage/Pound/',
        require => Service['autofs'],
    }

    replace_original_with_symlink_to_alternate { '/etc/libvirt':
        alternate       => '/mnt-local/storage/etc/libvirt',
        backup          => "/etc/libvirt$SUFFIX",
        before          => Service['libvirtd'],
        notify          => Service['libvirtd'],
        original        => '/etc/libvirt',
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require         => Package['libvirt'],
        seltype         => 'virt_etc_t',
    }

    replace_original_with_symlink_to_alternate { '/var/lib/libvirt':
        alternate	=> '/mnt-local/storage/var/lib/libvirt',
        backup          => "/var/lib/libvirt$SUFFIX",
        before          => Service['libvirtd'],
        notify          => Service['libvirtd'],
        original        => '/var/lib/libvirt',
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require         => Package['libvirt'],
        seltype         => 'virt_var_lib_t',
    }

    # disabled until once again needed
    #   include mysql-server
    #   replace_original_with_symlink_to_alternate { '/var/lib/mysql':
    #       alternate	=> '/mnt-local/storage/var/lib/mysql',
    #       backup          => "/var/lib/mysql$SUFFIX",
    #       original        => '/var/lib/mysql',
    #       before          => Service['mysqld'],
    #       require         => Package['mysql-server'],
    #       seltype         => 'mysqld_db_t',
    #   }

    service { 'libvirtd':
        enable		=> true,
        ensure		=> running,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
        ],
    }

    # Prefer forced power off as it's much faster than suspending.
    service { 'libvirtd-guests':
        enable		=> false,
        ensure		=> stopped,
        hasrestart	=> true,
        hasstatus	=> true,
        require		=> [
        ],
    }

    mailalias { 'root':
        ensure          => present,
        recipient       => 'john.florian@dart.biz',
    }

    # Make root user source my prophile by default.
    exec { 'prophile-install -f jflorian':
        require => Package['prophile'],
        unless  => 'grep -q prophile /root/.bash_profile',
    }

    file { '/root/.gvimrc_site':
        group	=> 'root',
        mode    => '0644',
        owner   => 'root',
        source  => 'puppet:///private-host/gvimrc_site',
    }

    file { '/root/.gitconfig':
        group	=> 'root',
        mode    => '0644',
        owner   => 'root',
        source  => 'puppet:///private-host/git/gitconfig',
    }

    file { '/root/.gitignore':
        group	=> 'root',
        mode    => '0644',
        owner   => 'root',
        source  => 'puppet:///private-host/git/gitignore',
    }

    cron { 'daily-git-summary':
        command         => '~/bin/git-summary',
        environment     => 'PATH=/usr/bin:/bin:/usr/games:/usr/local/sbin:/usr/sbin:/sbin:~/bin',
        user            => 'd13677',
        hour            => 7,
        minute          => 52,
        weekday         => ['1-5'],
    }

}
