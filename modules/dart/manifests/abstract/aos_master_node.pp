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
    ) inherits ::dart::abstract::server_node {

    include '::apache::params'

    # This is used by the Apache::Site_config['django-apps'] template.
    $python_base="/usr/lib/python${python_ver}/site-packages"

    class { '::apache':
        network_connect => true,
        use_nfs         => true,
    }

    ::apache::site_config { 'pub':
        source => 'puppet:///modules/dart/mdct-aos-master/httpd/pub.conf',
    }

    file { '/var/www/html/index.html':
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/dart/mdct-aos-master/httpd/index.html',
    }

    ::systemd::mount { '/var/www/pub':
        mnt_description => '/pub served via httpd',
        mnt_what        => '/mnt/pub',
        mnt_options     => 'bind,context=system_u:object_r:httpd_sys_content_t',
        mnt_requires    => 'autofs.service',
        mnt_after       => 'autofs.service',
        require         => Class['::autofs', '::apache'],
    }

    include '::dart::subsys::autofs::common'

    group { $django_group:
        system  => true,
    }

    user { $django_user:
        comment   => 'Django application WSGI daemon account',
        home      => '/var/www/',
        password  => '!',
        system    => true,
        subscribe => Group[$django_group],
        before    => Class['::dhcpd_driven::master'],
        notify    => Class['::dhcpd_driven::master'],
    }

    class { '::dhcpd_driven::master':
        before => Service[$::apache::params::services],
        notify => Service[$::apache::params::services],
        source => 'puppet:///modules/dart/mdct-aos-master/dhcpd-driven/dhcpd-driven.conf',
    }

    class { '::firewall_driven::master':
        before => Service[$::apache::params::services],
        notify => Service[$::apache::params::services],
        source => 'puppet:///modules/dart/mdct-aos-master/firewall-driven/firewall-driven.conf',
    }

    ::apache::site_config { 'django-apps':
        content  => template('dart/httpd/aos-master-django-apps.erb'),
    }

    include '::flock_herder'

    class { '::mdct_puppeteer::admin':
        source  => 'puppet:///modules/dart/mdct_puppeteer/mdct-puppeteer-admin.conf',
    }

    include '::postgresql::server'

    Postgresql::Server::Pg_hba_rule {
        auth_method => 'trust',
        order       => '001',
        type        => 'local',
        user        => 'root',
    }

    ::postgresql::server::pg_hba_rule {
        'allow root user connections to managed_firewalls via Unix domain socket':
            database => 'managed_firewalls',
        ;
        'allow root user connections to managed_switches via Unix domain socket':
            database => 'managed_switches',
        ;
    }

    include 'vsftpd'

    # vsftpd will deny clients access to /pub/mdct-aos-flash/ so we must rbind
    # mount that content to an acceptable location.
    systemd::mount { '/var/ftp/pub':
        mnt_description => '/pub served via vsftpd',
        mnt_what        => '/mnt/pub',
        mnt_options     => 'rbind',
        mnt_requires    => 'autofs.service',
        mnt_after       => 'autofs.service',
        require         => Class['::autofs', '::vsftpd'],
    }

    class { '::iptables':
        enabled        => true,
        kernel_modules => 'nf_conntrack_ftp',
    }

    iptables::rules_file { 'blocks':
        source => 'puppet:///modules/dart/mdct-aos-master/iptables/blocks',
    }

    class { '::selinux':
        mode => 'enforcing',
    }

    ::sendmail::alias { 'root':
        recipient => 'john.florian@dart.biz',
    }

    # All AOS Masters require the same SSH host keys lest the nodes not
    # implicitly trust them.  This is especially important when the AOS Master
    # is being replaced with a fresh build and there's a transitional period.
    # Note that OpenSSH is necessarily forgiving of a mismatch for the
    # hostname and/or IP address of the AOS Master.
    ::openssh::hostkey {
        'ssh_host_ecdsa_key':
            private_source => 'puppet:///modules/dart/mdct-aos-master/ssh/ssh_host_ecdsa_key',
            public_source  => 'puppet:///modules/dart/mdct-aos-master/ssh/ssh_host_ecdsa_key.pub',
            ;
        'ssh_host_ed25519_key':
            private_source => 'puppet:///modules/dart/mdct-aos-master/ssh/ssh_host_ed25519_key',
            public_source  => 'puppet:///modules/dart/mdct-aos-master/ssh/ssh_host_ed25519_key.pub',
            ;
        'ssh_host_rsa_key':
            private_source => 'puppet:///modules/dart/mdct-aos-master/ssh/ssh_host_rsa_key',
            public_source  => 'puppet:///modules/dart/mdct-aos-master/ssh/ssh_host_rsa_key.pub',
            ;
    }

    # The builder package is mostly needed here for the yum-snapshot tool.
    package { 'builder':
        ensure => 'latest',
    }

}
