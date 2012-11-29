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

    cron::jobfile { 'mirrmaid':
        require => [
            File['/etc/mirrmaid/mirrmaid.conf'],
            Package['mirrmaid'],
        ],
        source  => 'puppet:///private-host/mirrmaid/mirrmaid.cron',
    }

}
