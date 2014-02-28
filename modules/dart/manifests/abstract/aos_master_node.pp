# modules/dart/manifests/abstract/aos_master_node.pp
#
# == Class: dart::abstract::aos_master_node
#
# Configures a AOS Master host.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class dart::abstract::aos_master_node inherits dart::abstract::server_node {

    class { 'apache':
        use_nfs => true,
    }

    apache::site_config { 'pub':
        source  => 'puppet:///private-host/apache/pub.conf',
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

    group { 'django':
        system  => true,
    }

    user { 'django':
        comment     => 'Django application WSGI daemon account',
        home        => '/var/www/',
        password    => '!',
        system      => true,
        subscribe   => Group['django'],
        before      => Class['dhcpd_driven::master'],
        notify      => Class['dhcpd_driven::master'],
    }

    class { 'dhcpd_driven::master':
        python_ver      => '2.7',
        settings        => 'puppet:///private-host/dhcpd-driven/dhcpd-driven.conf',
        django_user     => 'django',
        django_group    => 'django',
    }

    include 'flock_herder'
    include 'mdct_puppeteer_admin'

    class { 'postgresql::server':
        hba_conf    => 'puppet:///private-host/postgresql/pg_hba.conf',
    }

    class { 'puppet::client':
    }

    class { 'vsftpd':
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
        notify  => Class['openssh_server'],
        source  => 'puppet:///private-domain/ssh/aos-master-host_rsa_key',
    }

    file { '/etc/ssh/ssh_host_rsa_key.pub':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        notify  => Class['openssh_server'],
        source  => 'puppet:///private-domain/ssh/aos-master-host_rsa_key.pub',
    }

}
