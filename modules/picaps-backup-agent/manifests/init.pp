# modules/picaps-backup-agent/manifests/init.pp
#
# Synopsis:
#       Configures a host as a picaps-backup-agent.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       NONE
#
# Requires:
#       NONE
#
# Example usage:
#
#       include picaps-backup-agent

class picaps-backup-agent {

    include cron::daemon

    package { 'picaps-backup-agent':
        ensure  => latest,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        subscribe   => Package['picaps-backup-agent'],
    }

    file { '/etc/picaps-backup-agent.conf':
        source  => 'puppet:///modules/picaps-backup-agent/picaps-backup-agent.conf',
    }

    cron::jobfile { 'picaps-backup-agent':
        require => [
            Package['picaps-backup-agent'],
        ],
        source  => 'puppet:///private-host/picaps-backup-agent/picaps-backup-agent.cron',
    }

}
