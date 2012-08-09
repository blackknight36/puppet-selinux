# modules/mirrmaid/manifests/init.pp
#
# Synopsis:
#       Configures a host for mirrmaid service.
#
# Note:
#       You will need to configure mirrmaid with one or configuration files
#       via mirrmaid::config.


class mirrmaid {

    include cron::daemon

    package { 'mirrmaid':
        ensure  => latest,
    }

    # TODO: move this to openssh module as a definition there.
    file { '/etc/mirrmaid/.ssh':
        ensure  => directory,
        owner   => 'mirrmaid',
        group   => 'mirrmaid',
        mode    => '0600',      # puppet will +x for directories
        force   => true,
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
