# modules/dart/manifests/abstract/aos_master_node.pp
#
# == Class: dart::abstract::aos_master_node
#
# Configures a AOS Master host.
#
# === Parameters
#
# [*python_ver*]
#   Python version that will run the deployment.
#
# [*django_user*]
#   ID of the user account under which the Django app will run within the WSGI
#   daemon.
#
# [*django_group*]
#   ID of the group account under which the Django app will run within the
#   WSGI daemon.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::abstract::aos_master_node (
        $python_ver, $django_user, $django_group,
    ) inherits dart::abstract::server_node {

    include 'apache::params'

    $python_base="/usr/lib/python${python_ver}/site-packages"

    class { 'apache':
        network_connect => true,
        use_nfs         => true,
    }

    apache::site_config { 'pub':
        source  => 'puppet:///private-host/apache/pub.conf',
    }

    file { '/var/www/html/index.html':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => 'puppet:///private-host/apache/index.html',
    }

    systemd::mount { '/var/www/pub':
        mnt_description => '/pub served via httpd',
        mnt_what        => '/mnt/pub',
        mnt_options     => 'bind,context=system_u:object_r:httpd_sys_content_t',
        mnt_requires    => 'autofs.service',
        mnt_after       => 'autofs.service',
        require         => Class['autofs', 'apache'],
    }

    include 'dart::subsys::autofs::common'

    group { $django_group:
        system  => true,
    }

    user { $django_user:
        comment     => 'Django application WSGI daemon account',
        home        => '/var/www/',
        password    => '!',
        system      => true,
        subscribe   => Group[$django_group],
        before      => Class['dhcpd_driven::master'],
        notify      => Class['dhcpd_driven::master'],
    }

    class { 'dhcpd_driven::master':
        before  => Service[$apache::params::services],
        notify  => Service[$apache::params::services],
        source  => 'puppet:///private-host/dhcpd-driven/dhcpd-driven.conf',
    }

    class { 'firewall_driven::master':
        before  => Service[$apache::params::services],
        notify  => Service[$apache::params::services],
        source  => 'puppet:///private-host/firewall-driven/firewall-driven.conf',
    }

    apache::site_config { 'django-apps':
        content  => template('dart/httpd/aos-master-django-apps.erb'),
    }

    include 'flock_herder'

    class { 'mdct_puppeteer::admin':
        source  => 'puppet:///modules/dart/mdct_puppeteer/mdct-puppeteer-admin.conf',
    }

#    class { 'postgresql::server':
#        hba_conf    => 'puppet:///private-host/postgresql/pg_hba.conf',
#    }

    class { 'vsftpd':
        source          => 'puppet:///private-host/vsftpd/vsftpd.conf',
        allow_use_nfs   => true,
    }

    # vsftpd will deny clients access to /pub/mdct-aos-flash/ so we must rbind
    # mount that content to an acceptable location.
    systemd::mount { '/var/ftp/pub':
        mnt_description => '/pub served via vsftpd',
        mnt_what        => '/mnt/pub',
        mnt_options     => 'rbind',
        mnt_requires    => 'autofs.service',
        mnt_after       => 'autofs.service',
        require         => Class['autofs', 'vsftpd'],
    }

    class { 'iptables':
        enabled         => true,
        kernel_modules  => 'nf_conntrack_ftp',
    }

    iptables::rules_file { 'blocks':
        source  => 'puppet:///private-host/iptables/blocks',
    }

    class { 'selinux':
        mode    => 'enforcing',
    }

    sendmail::alias { 'root':
        recipient   => 'john.florian@dart.biz',
    }

    # All AOS Masters require the same SSH host keys lest the nodes not
    # implicitly trust them.  This is especially important when the AOS Master
    # is being replaced with a fresh build and there's a transitional period.
    file { '/etc/ssh/ssh_host_rsa_key':
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'sshd_key_t',
        notify  => Class['openssh::server'],
        source  => 'puppet:///private-domain/ssh/aos-master-host_rsa_key',
    }

    file { '/etc/ssh/ssh_host_rsa_key.pub':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        notify  => Class['openssh::server'],
        source  => 'puppet:///private-domain/ssh/aos-master-host_rsa_key.pub',
    }

    # The builder package is mostly needed here for the yum-snapshot tool.
    package { 'builder':
        ensure  => 'latest',
    }

}
