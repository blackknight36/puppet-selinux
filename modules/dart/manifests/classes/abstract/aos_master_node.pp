# modules/dart/manifests/classes/aos_master_node.pp

class dart::aos_master_node inherits dart::server_node {

    include 'apache'

    apache::bind-mount { 'pub':
        source  => '/pub/',
    }

    apache::site-config { 'pub':
        notify  => Service['httpd'],
        source  => 'puppet:///private-host/apache/pub.conf',
    }

    include 'flock-herder'
    include 'mdct-puppeteer-admin'

    class { 'vsftpd':
        allow_use_nfs      => true,
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
        enabled => true,
        kernel_modules  => 'nf_conntrack_ftp',
    }

    lokkit::rules_file { 'blocks':
        source  => 'puppet:///private-host/lokkit/blocks',
    }

    mailalias { "root":
        ensure          => present,
        recipient       => "john.florian@dart.biz",
    }

}
