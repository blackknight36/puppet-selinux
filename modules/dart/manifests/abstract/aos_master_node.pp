# modules/dart/manifests/abstract/aos_master_node.pp

class dart::abstract::aos_master_node inherits dart::abstract::server_node {

    class { 'apache':
        use_nfs => 'on',
    }

    apache::bind-mount { 'pub':
        source  => '/pub/',
    }

    apache::site-config { 'pub':
        source  => 'puppet:///private-host/apache/pub.conf',
    }

    class { 'dart::subsys::autofs::common':
        legacy  => false,
    }

    include 'flock-herder'
    include 'mdct-puppeteer-admin'

    class { 'puppet::client':
    }

    class { 'vsftpd':
        allow_use_nfs   => true,
    }

    # vsftpd will deny clients access to /pub/mdct-aos-flash/ so we must rbind
    # mount that content to an acceptable location.
    mount { '/var/ftp/pub':
        atboot  => true,
        device  => '/mnt/pub',
        ensure  => 'mounted',
        fstype  => 'none',
        options => '_netdev,rbind',
        require => Class['vsftpd'],
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

    mailalias { 'root':
        ensure      => present,
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
        notify  => Class['openssh-server'],
        source  => 'puppet:///private-domain/ssh/aos-master-host_rsa_key',
    }

    file { '/etc/ssh/ssh_host_rsa_key.pub':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        notify  => Class['openssh-server'],
        source  => 'puppet:///private-domain/ssh/aos-master-host_rsa_key.pub',
    }

}
