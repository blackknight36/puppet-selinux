# modules/dart/manifests/mdct-dev12.pp

class dart::mdct-dev12 inherits dart::abstract::workstation_node {

    class { 'network':
        network_manager => false,
        domain          => 'dartcontainer.com',
        name_servers    => ['10.1.0.98', '10.1.0.99'],
    }

    network::interface { 'br0':
        template => 'static-bridge',
        ip_address  => '10.1.0.158',
        netmask     => '255.255.0.0',
        gateway     => '10.1.0.25',
    }

    network::interface { 'em1':
        template    => 'static',
        bridge      => 'br0',
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
    include 'dart::subsys::yum_cron'

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

    oracle::jdk { 'jdk-7u25-linux-x64':
        ensure  => 'present',
        version => '7',
        update  => '25',
    }

    $SUFFIX=".orig-${operatingsystem}${operatingsystemrelease}"

    file { '/j':
        ensure  => '/mnt-local/storage/j/',
        require => Service['autofs'],
    }

    file { '/s':
        ensure  => '/mnt-local/storage/',
        require => Service['autofs'],
    }

    file { '/Pound':
        ensure  => '/mnt-local/storage/Pound/',
        require => Service['autofs'],
    }

    dart::util::replace_original_with_symlink_to_alternate { '/etc/libvirt':
        alternate   => '/mnt-local/storage/etc/libvirt',
        backup      => "/etc/libvirt$SUFFIX",
        before      => Service['libvirtd'],
        notify      => Service['libvirtd'],
        original    => '/etc/libvirt',
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require     => Package['libvirt'],
        seltype     => 'virt_etc_t',
    }

    dart::util::replace_original_with_symlink_to_alternate { '/var/lib/libvirt':
        alternate   => '/mnt-local/storage/var/lib/libvirt',
        backup      => "/var/lib/libvirt$SUFFIX",
        before      => Service['libvirtd'],
        notify      => Service['libvirtd'],
        original    => '/var/lib/libvirt',
        # TODO: libvirt needs to be a formal service and treated here like
        # mysql WRT before/require attrs
        require     => Package['libvirt'],
        seltype     => 'virt_var_lib_t',
    }

    # disabled until once again needed
    #   include mysql-server
    #   dart::util::replace_original_with_symlink_to_alternate { '/var/lib/mysql':
    #       alternate   => '/mnt-local/storage/var/lib/mysql',
    #       backup      => "/var/lib/mysql$SUFFIX",
    #       original    => '/var/lib/mysql',
    #       before      => Service['mysqld'],
    #       require     => Package['mysql-server'],
    #       seltype     => 'mysqld_db_t',
    #   }

    service { 'libvirtd':
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
        require     => [
        ],
    }

    # Prefer forced power off as it's much faster than suspending.
    service { 'libvirtd-guests':
        enable      => false,
        ensure      => stopped,
        hasrestart  => true,
        hasstatus   => true,
        require     => [
        ],
    }

    mailalias { 'root':
        ensure      => present,
        recipient   => 'john.florian@dart.biz',
    }

    # Make root user source my prophile by default.
    exec { 'prophile-install -f jflorian':
        require => Package['prophile'],
        unless  => 'grep -q prophile /root/.bash_profile',
    }

    file { '/root/.gvimrc_site':
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        source  => 'puppet:///private-host/gvimrc_site',
    }

    file { '/root/.gitconfig':
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        source  => 'puppet:///private-host/git/gitconfig',
    }

    file { '/root/.gitignore':
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        source  => 'puppet:///private-host/git/gitignore',
    }

    cron::job { 'git-summary':
        command => 'nice ionice -c 3 git-summary',
        dow     => 'Mon-Fri',
        hour    => '7',
        minute  => '33',
        user    => 'd13677',
        mailto  => 'john.florian@dart.biz',
    }

}
