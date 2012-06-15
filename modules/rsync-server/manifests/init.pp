# modules/rsync-server/manifests/init.pp

class rsync-server {

    include lokkit
    include xinetd

    package { 'rsync':
	ensure	=> installed,
    }

    file { '/etc/xinetd.d/rsync':
        group	=> 'root',
        mode    => '0644',
        notify  => Service['xinetd'],
        owner   => 'root',
        require => Package['rsync'],
        source  => [
            'puppet:///private-host/xinetd.d/rsync',
            'puppet:///modules/rsync-server/rsync',
        ],
    }

    file { '/etc/rsyncd.conf':
        group	=> 'root',
        mode    => '0644',
        notify  => Service['xinetd'],
        owner   => 'root',
        require => Package['rsync'],
        source  => [
            'puppet:///private-host/rsync-server/rsyncd.conf',
            'puppet:///private-domain/rsync-server/rsyncd.conf',
            'puppet:///modules/rsync-server/rsyncd.conf',
        ],
    }

    lokkit::tcp_port { 'rsync':
        port    => '873',
    }

    selinux::boolean { 'rsync_export_all_ro':
        persistent      => true,
        value           => on,
    }

}
