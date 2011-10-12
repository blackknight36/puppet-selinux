# modules/repoview/manifests/init.pp

class repoview {

    package { 'repoview':
	ensure	=> installed,
    }

    file { '/usr/libexec/mdct-repoview':
        group	=> 'root',
        mode    => '0755',
        owner   => 'root',
        source  => 'puppet:///modules/repoview/mdct-repoview',
    }

    file { '/var/lib/mdct-repoview':
        ensure  => 'directory',
        group	=> 'root',
        mode    => '0755',
        owner   => 'root',
    }

    cron:jobfile { 'mdct-repoview':
        require => [
            File['/usr/libexec/mdct-repoview'],
            File['/var/lib/mdct-repoview'],
            Package['repoview'],
        ],
        source  => 'puppet:///modules/repoview/mdct-repoview.cron',
    }

}
