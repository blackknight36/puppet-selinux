# modules/repoview/manifests/init.pp

class repoview {

    include cron::daemon

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

    cron::job { 'mdct-repoview':
        command => 'nice ionice -c 3 /usr/libexec/mdct-repoview 16 15 14 13 12 11 10 8',
        minute  => '42',
        hour    => '*/4',
        require => [
            File['/usr/libexec/mdct-repoview'],
            File['/var/lib/mdct-repoview'],
            Package['repoview'],
        ],
    }

}
