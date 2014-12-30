# modules/repoview/manifests/init.pp

class repoview {

    include 'cron::daemon'

    package { 'repoview':
        ensure  => installed,
    }

    File {
        owner   => 'root',
        group   => 'repomgr',
        mode    => '0755',
    }

    file {
        '/usr/libexec/mdct-repoview':
            source  => 'puppet:///modules/repoview/mdct-repoview';

        ['/var/lib/mdct-repoview', '/var/log/mdct-repoview']:
            ensure  => 'directory',
            mode    => '0775';
    }

    cron::job { 'mdct-repoview':
        command => 'nice ionice -c 3 /usr/libexec/mdct-repoview 21 20 19 18 17 16 15 14 13 12 11 10 8',
        minute  => '42',
        hour    => '*/4',
        user    => 'repomgr',
        require => [
            File['/usr/libexec/mdct-repoview'],
            File['/var/lib/mdct-repoview'],
            Package['repoview'],
        ],
    }

}
