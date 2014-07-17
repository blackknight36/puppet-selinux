# modules/dart/manifests/mdct_dev12.pp
#
# == Class: dart::mdct_dev12
#
# Configures a host as John Florian's workstation.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::mdct_dev12 inherits dart::abstract::workstation_node {

    class { 'network':
        service         => 'nm',
        domain          => $dart::params::dns_domain,
        name_servers    => $dart::params::dns_servers,
    }

    network::interface { 'br0':
        template    => 'static-bridge',
        ip_address  => '10.1.0.158',
        netmask     => '255.255.0.0',
        gateway     => '10.1.0.25',
        stp         => 'no',
    }

    network::interface { 'em1':
        template    => 'static',
        bridge      => 'br0',
    }

    class { 'plymouth':
        theme   => 'details',
    }

    # Apache httpd is needed for at least serving man2html, but may be used
    # for development and/or debugging setups of dhcpd-driven-master or
    # firewall-driven-master, hence the network_connect setting.
    class { 'apache':
        network_connect => true,
    }

    class { 'bacula::admin':
        dir_address => "mdct-00bk.${domain}",
        dir_name    => 'mdct-00bk-dir',
        dir_passwd  => 'a/kIuMrD+AIJxl5HlDZhdEdugagOer5nUi43qgip2DED',
    }

    class { 'bacula::client':
        dir_name    => $dart::params::bacula_dir_name,
        dir_passwd  => 'RB9c3KBgpRyXzbGC6wXCEA5ao2SAtgAyt24tD8pni17h',
        mon_name    => $dart::params::bacula_mon_name,
        mon_passwd  => 'NBkHwmNJGplxIlmMaQukmf568KCSuY1eKDGINZnLxyTw',
    }

    include 'dart::abstract::pycharm::professional'
    include 'dart::subsys::yum_cron'

    class { 'koji::cli':
        hub         => 'http://mdct-koji.dartcontainer.com/kojihub',
        web         => 'http://mdct-koji.dartcontainer.com/koji',
        downloads   => 'http://mdct-koji.dartcontainer.com/kojifiles',
        top_dir     => '/srv/koji',     # TODO: share via NFS?
    }

    iptables::rules_file { 'blocks':
        source  => 'puppet:///private-host/iptables/blocks',
    }

    printer { 'dell':
        uri         => 'socket://10.209.123.23:9100',
        description => 'Dell 3100cn',
        location    => 'Florian\'s office',
        model       => 'foomatic:Dell-3100cn-pxlcolor.ppd',
    }

    class { 'selinux':
        mode => 'enforcing',
    }

    package { [
        'kcometen4',
        'kde-plasma-yawp',
        'kdeartwork-screensavers',
        'kio_mtp',
        'man2html',
        'qstars-kde',
        'redshift',
        'rss-glx-kde',
        'tempest-kde',
    ]:
        ensure  => installed,
    }

    $SUFFIX=".orig-${operatingsystem}${operatingsystemrelease}"

    autofs::map_entry {

        '/mnt/mas-fs02-d13677':
            mount   => '/mnt',
            key     => 'mas-fs02-d13677',
            options => '-fstype=cifs,uid=d13677,gid=d13677,credentials=/mnt/storage/j/.credentials/d13677.cifs',
            remote  => '://mas-fs02/Users/d13677';

        '/mnt/mas-fs01-eng':
            mount   => '/mnt',
            key     => 'mas-fs01-eng',
            options => '-fstype=cifs,credentials=/mnt/storage/j/.credentials/d13677.cifs',
            remote  => '://mas-fs01/Eng';

        '/mnt/mas-fs01-sharedata':
            mount   => '/mnt',
            key     => 'mas-fs01-sharedata',
            options => '-fstype=cifs,credentials=/mnt/storage/j/.credentials/d13677.cifs',
            remote  => '://mas-fs01/ShareData';

        '/mnt/koji':
            mount   => '/mnt',
            key     => 'koji',
            options => '-rw,hard,nosuid,noatime,fsc',
            remote  => 'mdct-00fs:/storage/projects/koji';

        '/mnt/storage':
            mount   => '/mnt',
            key     => 'storage',
            options => '-fstype=ext4,rw',
            remote  => ':/dev/data/storage';

    }

    file { '/j':
        ensure  => link,
        target  => '/mnt/storage/j/',
    }

    file { '/Pound':
        ensure  => link,
        target  => '/mnt/storage/Pound/',
    }

    dart::util::replace_original_with_symlink_to_alternate { '/etc/libvirt':
        alternate   => '/mnt/storage/etc/libvirt',
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
        alternate   => '/mnt/storage/var/lib/libvirt',
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
    #   include 'mysql_server'
    #   dart::util::replace_original_with_symlink_to_alternate { '/var/lib/mysql':
    #       alternate   => '/mnt/storage/var/lib/mysql',
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

    sendmail::alias { 'root':
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

    mock::user {
        'd13677':;
    }

}
