# modules/mirrmaid/manifests/init.pp

class mirrmaid {

    include cron::daemon

    package { 'mirrmaid':
        ensure  => latest,
    }

    file { '/etc/mirrmaid/mirrmaid.conf':
        group   => 'mirrmaid',
        mode    => '0644',
        owner   => 'root',
        require => Package['mirrmaid'],
        source  => 'puppet:///private-host/mirrmaid/mirrmaid.conf',
    }

    file { '/etc/mirrmaid/mirrmaid.conf-testing':
        group   => 'mirrmaid',
        mode    => '0644',
        owner   => 'root',
        require => Package['mirrmaid'],
        source  => 'puppet:///private-host/mirrmaid/mirrmaid.conf-testing',
    }

    file { '/etc/mirrmaid/.ssh':
        ensure  => directory,
        force   => true,
        group   => 'mirrmaid',
        mode    => '0600',      # puppet will +x for directories
        owner   => 'mirrmaid',
        purge   => true,
        recurse => true,
        require => Package['mirrmaid'],
        source  => 'puppet:///private-host/mirrmaid/.ssh',
    }

    cron::jobfile { 'mirrmaid':
        require => [
            File['/etc/mirrmaid/mirrmaid.conf'],
            Package['mirrmaid'],
        ],
        source  => 'puppet:///private-host/mirrmaid/mirrmaid.cron',
    }

}
