# modules/picaps/manifests/backup_agent.pp
#
# Synopsis:
#       Configures a host with the PICAPS Backup Agent.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       NONE


class picaps::backup_agent {

    include 'cron::daemon'

    include 'picaps::params'

    package { $picaps::params::backup_packages:
        ensure  => latest,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package[$picaps::params::backup_packages],
    }

    file { '/etc/picaps-backup-agent.conf':
        source  => "puppet:///modules/files/private/${fqdn}/picaps/picaps-backup-agent.conf",
    }

    cron::jobfile { 'picaps-backup-agent':
        require => Package[$picaps::params::backup_packages],
        source  => "puppet:///modules/files/private/${fqdn}/picaps/picaps-backup-agent.cron",
    }

}
