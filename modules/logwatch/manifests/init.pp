# modules/logwatch/manifests/init.pp

class logwatch {

    package { 'logwatch':
	ensure	=> installed,
    }

    file { '/etc/logwatch/conf/ignore.conf':
        group	=> 'root',
        mode    => '0640',
        owner   => 'root',
        require => Package['logwatch'],
        source  => [
            'puppet:///private-host/logwatch/ignore.conf',
            'puppet:///logwatch/ignore.conf',
        ],
    }

    file { '/etc/logwatch/conf/logwatch.conf':
        group	=> 'root',
        mode    => '0640',
        owner   => 'root',
        require => Package['logwatch'],
        source  => [
            'puppet:///private-host/logwatch/logwatch.conf',
            'puppet:///logwatch/logwatch.conf',
        ],
    }

    # There is no logwatch "service" to manage; it's just a cron job.

}
