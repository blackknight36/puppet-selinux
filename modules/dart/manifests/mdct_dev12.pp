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
        ip_address  => '10.209.23.1',
        netmask     => '255.255.252.0',
        gateway     => '10.209.23.254',
        stp         => 'no',
    }

    network::interface { 'enp0s25':
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
        dir_address => "mdct-00bk.${::domain}",
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
    include 'dart::mdct_dev12::filesystem'
    include 'dart::mdct_dev12::libvirt'
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

    sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

    # Make root user source my prophile by default.
    exec { 'prophile-install -f jflorian':
        require => Package['prophile'],
        unless  => 'grep -q prophile /root/.bash_profile',
    }

    # Ditch the KDE screenlocker in favor of xscreensaver.
    file { '/usr/libexec/kde4/kscreenlocker_greet':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        source  => 'puppet:///private-host/kscreenlocker_greet',
    }

    file { '/root/.gvimrc_site':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => 'puppet:///private-host/gvimrc_site',
    }

    file { '/root/.gitconfig':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => 'puppet:///private-host/git/gitconfig',
    }

    file { '/root/.gitignore':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
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
