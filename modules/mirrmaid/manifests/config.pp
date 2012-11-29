# modules/mirrmaid/manifests/config.pp
#
# Synopsis:
#       Installs a mirrmaid configuration file.
#
# Parameters:
#       Name__________  Notes_  Description___________________________________
#
#       name                    instance name
#
#       ensure          1       instance is to be present/absent
#
#       source                  URI of the configuration file to be installed
#
#       cronjob         2       URI of the cron job file to be installed
#
# Notes:
#
#       1. Default is 'present'.
#
#       2. Use the default (undef) if you do not want a cron job file
#       installed.  For format and any other requirements, see cron::jobfile
#       definition for more details.


define mirrmaid::config ($ensure='present', $source, $cronjob=undef) {

    include 'cron::daemon'

    file { "/etc/mirrmaid/${name}.conf":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'mirrmaid',
        mode    => '0644',
        require => Package['mirrmaid'],
        source  => "${source}",
    }

    if $cronjob != undef {

        cron::jobfile { "${name}":
            require => Class['mirrmaid'],
            source  => "${cronjob}",
        }

    }

}
