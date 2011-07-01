# /etc/puppet/modules/repoview/manifests/init.pp

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

    file { '/etc/cron.d/mdct-repoview':
        group	=> 'root',
        mode    => '0644',
        owner   => 'root',
        require => [
            #Service['crond'],  # if there were such a module
            File['/usr/libexec/mdct-repoview'],
            File['/var/lib/mdct-repoview'],
            Package['repoview'],
        ],
        source  => 'puppet:///modules/repoview/mdct-repoview.cron',
    }

}
